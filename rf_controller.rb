require "yaml"
require "pi_piper"
include PiPiper

class RFController
    def initialize
        @ledOut = PiPiper::Pin.new(pin: 4, direction: :out)
        @outlets = {
            "basement" => {
                "main" => "off"
            }
        }

        @signals = YAML.load_file("signals.yml")
    end

    def sigOut(area, name)
        return if @outlet[area].nil? || @outlet[area][name].nil?

        which = @outlets[area][name] == "on" ?
            @signals[area][name]["off"] :
            @signals[area][name]["on"]
        
        system("./codesend #{which} 0 175")

        code = $?.exitstatus
        if code == 0
            @ledOut.on
            sleep 0.25
            @ledOut.off
            @baseMainOn ? @baseMainOn = false : @baseMainOn = true
        end
    end
end