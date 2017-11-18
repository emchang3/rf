require_relative "rf_controller"

rfc = RFController.new
while true do
    print "Which switch? "
    input = gets.chomp.split(" ")
    rfc.sigOut(input[0], input[1])
    break if input == "q"
end