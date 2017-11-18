require "yaml"
require "pi_piper"
include PiPiper

class RFController
    def initialize
        @ledOut = PiPiper::Pin.new(pin: 4, direction: :out)
        @outlets = {
            "basement" => { "main" => "off" },
            "living" => { "front" => "off" },
            "bed" => { "head" => "off" }
        }

        @signals = YAML.load_file("signals.yml")

        @signals.each do |a, b|
            puts "#{a}: #{b}"
            puts "-----"
            b.each do |c, d|
                puts "#{c}: #{d}"
                puts "-----"
            end
        end
    end

    def sigOut(area, name)
        return if @outlets[area].nil? || @outlets[area][name].nil?

        which = @outlets[area][name] == "on" ?
            @signals[area][name]["off"] :
            @signals[area][name]["on"]
        
        system("./codesend #{which} 0 175")

        code = $?.exitstatus
        if code == 0
            @ledOut.on
            sleep 0.25
            @ledOut.off
            @outlets[area][name] == "on" ?
                @outlets[area][name] = "off" :
                @outlets[area][name] = "on"
        end
    end
end