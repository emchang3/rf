require "pi_piper"
include PiPiper

watch :pin => 27 do
    puts value
  end

PiPiper.wait