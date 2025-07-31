# app.rb

require 'httparty'
require 'colorize'
require_relative './lib/portfolio'
require_relative './lib/alert'
require_relative './lib/rebalance'
require_relative './lib/simulation'
require_relative './lib/alert_storage'



def main_menu
  puts "\n📊 Welcome to Smart Invest MX".colorize(:cyan)
  puts "1. View Portfolio"
  puts "2. Simulate Dividends"
  puts "3. Set Price Alerts"
  puts "4. Simulate Rebalance"
  puts "5. Simulate Growth with Dividends"
  puts "6. Check Saved Alerts"
  puts "7. Delete Alert by Ticker"
  puts "8. Edit Alert Price"
  puts "9. Exit"
  print "Choose an option: "
  gets.chomp.to_i
end


def run_app
  # Initialize alerts by loading them from the CSV file
  alerts = AlertStorage.load_alerts
  
  loop do
    case main_menu
    when 1
      Portfolio.view_positions
    when 2
      Portfolio.simulate_dividends
    when 3
      # Add a new alert
      puts "Enter ticker:"
      ticker = gets.chomp
      puts "Enter target price:"
      target_price = gets.chomp

      new_alert = { 'Ticker' => ticker, 'Target Price' => target_price, 'Status' => 'Active' }
      Alert.set_alerts(alerts, new_alert)
    when 4
      Rebalance.rebalance_flow
    when 5
      Simulation.simulate_growth_flow 
    when 6
      #AlertStorage.check_saved_alerts
      Alert.display_alerts(alerts)
    when 7
      AlertStorage.delete_alert_by_ticker
    when 8
      alerts = AlertStorage.load_alerts # Load all alerts
      print "Enter the criteria to search alerts (e.g., Ticker):  "
      search_criteria = gets.chomp
      matches = alerts.select { |alert| alert['Ticker'].include?(search_criteria) } # Filter alerts
      AlertStorage.edit_alert_price(alerts, matches) # Pass alerts and matches  
    when 9
      puts "\nGracias por usar Smart Invest MX. ¡Hasta pronto!".colorize(:green)
      break
    else
      puts "Invalid option. Please try again.".colorize(:red)
    end
  end
end


run_app
