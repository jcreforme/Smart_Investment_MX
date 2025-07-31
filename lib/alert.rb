require 'csv'
require 'httparty'
require 'colorize'

class Alert
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

  # Fetch the current stock price from an API
  def self.fetch_stock_price(url, retries = 0, max_retries = 3)
    begin
      response = HTTParty.get(url)

      # Handle HTTP errors
      if response.code == 429
        raise "Rate limit exceeded"
      elsif response.code != 200
        puts "⚠️ Error: No se pudo obtener datos del servidor (Código: #{response.code}).".colorize(:red)
        return nil
      end

      # Parse the response and extract the price
      parsed_response = response.parsed_response
      price = parsed_response.dig("Global Quote", "05. price")
      return price ? price.to_f.round(2) : nil
    rescue StandardError => e
      if retries < max_retries
        retries += 1
        puts "⚠️ Error: #{e.message}. Reintentando (#{retries}/#{max_retries})...".colorize(:yellow)
        sleep(1) # Wait before retrying
        retry
      else
        puts "❌ Error: No se pudo obtener el precio después de varios intentos.".colorize(:red)
        return nil
      end
    end
  end

  # Set alerts for stock prices
  def self.set_alerts(alerts, new_alert)
    # Check for duplicate tickers
    duplicate_alerts = alerts.select { |alert| alert['Ticker'] == new_alert['Ticker'] }
  
    if duplicate_alerts.any?
      puts "⚠️ Advertencia: Ya existen alertas para el ticker #{new_alert['Ticker']}.".colorize(:yellow)
      duplicate_alerts.each do |alert|
        puts "   - ID: #{alert['ID']}, Precio objetivo: #{alert['Target Price']}, Estado: #{alert['Status']}"
      end
    end
  
    # Calculate the next available ID
    max_id = alerts.map { |alert| alert['ID'].to_i }.max || 0
    new_alert['ID'] = (max_id + 1).to_s
  
    # Add the new alert to the list
    alerts << new_alert
  
    # Save the updated alerts back to the CSV file
    save_alerts(alerts)
  
    puts "✅ Nueva alerta añadida con ID #{new_alert['ID']}.".colorize(:green)
  end

  # Display all alerts
  def self.display_alerts(alerts)
    if alerts.empty?
      puts "No hay alertas disponibles.".colorize(:yellow)
      return
    end

    puts "📋 Lista de alertas:".colorize(:cyan)
    alerts.each do |alert|
      puts "   - ID: #{alert['ID']}, Ticker: #{alert['Ticker']}, Precio objetivo: #{alert['Target Price']}, Estado: #{alert['Status']}"
    end
  end

  # Delete an alert by ID
  def self.delete_alert(alerts, id)
    alert_to_delete = alerts.find { |alert| alert['ID'] == id }
    if alert_to_delete
      alerts.delete(alert_to_delete)
      save_alerts(alerts)
      puts "✅ Alerta con ID #{id} eliminada.".colorize(:green)
    else
      puts "❌ No se encontró ninguna alerta con ID #{id}.".colorize(:red)
    end
  end
end