require "yaml"
require "pi_piper"
include PiPiper

class RFController
    def initialize
        @ledOut = PiPiper::Pin.new(pin: 4, direction: :out)
        @baseMainOn = false

        @signals = YAML.load_file("signals.yml")
    end

    def sigOut
        which = @baseMainOn ?
            @signals["basement"]["main"]["off"] :
            @signals["basement"]["main"]["on"]
        
        system("./codesend #{which} 0 175")
        code = $?.exitstatus
        puts "--- code: #{code}"

        if code == 0
            puts "Was 0."
            @ledOut.on
            sleep 0.25
            @ledOut.off
            @baseMainOn ? @baseMainOn = false : @baseMainOn = true
        end
    end
end