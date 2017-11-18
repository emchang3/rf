require "yaml"
require "pi_piper"
include PiPiper

class RFController
    def initialize
        @ledOut = PiPiper::Pin.new(pin: 4, direction: :out)
        @signals = YAML.load_file("signals.yml")
        @outlets = {}

        @signals.each do |a, b|
            @outlets[a] = {}
            b.each { |c, d| @outlets[a][c] = "off" }
        end
    end

    def flashLED
        @ledOut.on
        sleep 0.25
        @ledOut.off
    end

    def sigOut(area, name)
        return if @outlets[area].nil? || @outlets[area][name].nil?

        which = @outlets[area][name] == "on" ?
            @signals[area][name]["off"] :
            @signals[area][name]["on"]
        
        system("./codesend #{which} 0 175")

        code = $?.exitstatus
        if code == 0
            self.flashLED
            @outlets[area][name] == "on" ?
                @outlets[area][name] = "off" :
                @outlets[area][name] = "on"
        end
    end
end