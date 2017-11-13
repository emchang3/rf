require_relative "rf_controller"

rfc = RFController.new
while true do
    input = gets.chomp
    rfc.sigOut if input == "1"
    break if input == "0"
end