require "pi_piper"
include PiPiper

watch :pin => 4 do
    puts value
  end

PiPiper.wait