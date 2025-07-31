# lib/simulation.rb

module Simulation
    def self.simulate_growth_with_dividends(initial_investment, annual_returns, allocation, years)
      results = {}
  
      allocation.each do |asset, percentage|
        asset_investment = initial_investment * (percentage / 100.0)
        growth = asset_investment * ((1 + annual_returns[asset] / 100.0)**years)
        results[asset] = growth.round(2)
      end
  
      results
    end
  
    def self.display_simulation_results(results)
      total = results.values.sum.round(2)
      puts "
  💡 Simulación de Crecimiento con Reinversión de Dividendos:"
      results.each do |asset, value|
        puts "#{asset}: $#{value}"
      end
      puts "Total: $#{total}"
    end
  
    def self.simulate_growth_flow
      puts "
  💰 Simulación de crecimiento con reinversión de dividendos:".colorize(:yellow)
  
      print "Monto inicial ($): "; initial_investment = gets.chomp.to_f
      puts "Retorno anual estimado por tipo de activo:"
      annual_returns = {}
      print "FIBRAS (%): "; annual_returns["FIBRAS"] = gets.chomp.to_f
      print "GOLD (%): "; annual_returns["GOLD"] = gets.chomp.to_f
      print "ETFs (%): "; annual_returns["ETFs"] = gets.chomp.to_f
  
      allocation = Rebalance.ask_validated_allocation("asignación objetivo")
      print "Número de años: "; years = gets.chomp.to_i
  
      results = simulate_growth_with_dividends(initial_investment, annual_returns, allocation, years)
      display_simulation_results(results)
    end
  end