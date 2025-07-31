# lib/portfolio.rb

require 'json'
require 'colorize'

module Portfolio
  def self.load_fibras
    file = File.read('./data/portfolio.json')
    JSON.parse(file, symbolize_names: true)
  end

  def self.view_positions
    puts "\nTus posiciones FIBRA actuales:\n".colorize(:blue)
    load_fibras.each do |fibra|
      puts "#{fibra[:ticker]} | Precio: $#{fibra[:price]} | Yield: #{(fibra[:dividend_yield] * 100).round(2)}%".colorize(:light_yellow)
    end
  end

  def self.simulate_dividends
    puts "\n💸 Simulación de reinversión:\n".colorize(:magenta)
    load_fibras.each do |fibra|
      reinvestment = (fibra[:price] * fibra[:dividend_yield]).round(2)
      puts "#{fibra[:ticker]} → Reinvierte $#{reinvestment} por título".colorize(:light_green)
    end
  end
end
