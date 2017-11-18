require_relative "rf_controller"

rfc = RFController.new
while true do
    print "Which switch? "
    input = gets.chomp
    break if input == "q"
    parsed = input.split(" ")
    rfc.sigOut(parsed[0], parsed[1])
end