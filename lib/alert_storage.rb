require 'csv'
require 'colorize'

class AlertStorage
  # Define the constant for the alerts file at the class level
  ALERTS_FILE = File.expand_path('../data/alerts.csv', __dir__)

  # Load alerts from the CSV file
  def self.load_alerts
    return [] unless File.exist?(ALERTS_FILE) && !File.zero?(ALERTS_FILE)

    CSV.read(ALERTS_FILE, headers: true).map(&:to_h)
  end

  # Save alerts to the CSV file
  def self.save_alerts(alerts)
    CSV.open(ALERTS_FILE, 'w') do |csv|
      csv << ['ID', 'Ticker', 'Target Price', 'Status']
      alerts.each do |alert|
        csv << [alert['ID'], alert['Ticker'], alert['Target Price'], alert['Status']]
      end
    end
  end

  # Delete alerts by ticker
  def self.delete_alert_by_ticker
    alerts = load_alerts

    print "Enter the ticker symbol to delete: "
    ticker_to_delete = gets.chomp.upcase

    filtered_alerts = alerts.reject { |alert| alert['Ticker'] == ticker_to_delete }

    if alerts.size == filtered_alerts.size
      puts "❌ No alerts found with ticker '#{ticker_to_delete}'."
    else
      save_alerts(filtered_alerts)
      puts "✅ Alerts with ticker '#{ticker_to_delete}' have been deleted."
    end
  end

  # Edit the target price of an alert
  # Edit the target price of an alert
  def self.edit_alert_price(alerts, matches)
    if matches.empty?
      puts "❌ No alerts found matching the criteria."
      return
    end

    # Display matching alerts
    puts "Matching Alerts:"
    matches.each_with_index do |alert, index|
      puts "#{index + 1}. Ticker: #{alert['Ticker']}, Target Price: #{alert['Target Price']}, Status: #{alert['Status']}"
    end

    # Prompt the user to select an alert to edit
    print "Enter the number of the alert you want to edit (1-#{matches.size}): "
    choice = gets.chomp.to_i

    # Validate the user's choice
    if choice < 1 || choice > matches.size
      puts "❌ Invalid choice. Please enter a number between 1 and #{matches.size}."
      return
    end

    selected_alert = matches[choice - 1]

    # Prompt for the new target price
    print "Enter the new target price for #{selected_alert['Ticker']}: "
    new_price = gets.chomp

    # Validate the new price
    if new_price.to_f <= 0
      puts "❌ Invalid price. Please enter a positive number."
      return
    end

    # Update the alert
    selected_alert['Target Price'] = new_price

    # Save the updated alerts back to the CSV file
    save_alerts(alerts)
    puts "✅ Target price for #{selected_alert['Ticker']} has been updated to #{new_price}."
  end
end