# lib/rebalance.rb

# current_allocation = {
#   "FIBRAS" => 50,
#   "GOLD"   => 20,
#   "ETFs"   => 30
# }

# target_allocation = {
#   "FIBRAS" => 40,
#   "GOLD"   => 30,
#   "ETFs"   => 30
# }

module Rebalance

  def self.ask_validated_allocation(label)
    loop do
      allocation = ask_allocation(label)
      total = allocation.values.sum
      if total.round(2) == 100.0
        return allocation
      else
        puts "\n⚠️ La asignación total debe ser exactamente 100%. Actualmente es #{total.round(2)}%. Intenta de nuevo.".colorize(:red)
      end
    end
  end
  
  # 🛠️ Helper method to ask for allocation
  def self.ask_allocation(type)
    puts "\n📊 Ingresa tu asignación actual para #{type}:"
    print "FIBRAS (%): "; fibras = gets.chomp.to_f
    print "GOLD (%): "; gold = gets.chomp.to_f
    print "ETFs (%): "; etfs = gets.chomp.to_f

    {
      "FIBRAS" => fibras,
      "GOLD" => gold,
      "ETFs" => etfs
    }
  end

  def self.rebalance_flow
    # 🧠 CLI Flow
    puts "\n🔧 Simulación de Balanceo:"
    current_allocation = ask_validated_allocation("asignación actual")
    target_allocation  = ask_validated_allocation("asignación objetivo")


    balance_plan = calculate_rebalance(current_allocation, target_allocation)
    display_rebalance_plan(balance_plan)
  end

  def self.calculate_rebalance(current_allocation, target_allocation)
    rebalance_plan = {}

    current_allocation.each do |asset, current_weight|
      target_weight = target_allocation[asset] || 0
      rebalance_plan[asset] = target_weight - current_weight
    end

    rebalance_plan
  end

  def self.display_rebalance_plan(balance_plan)
    puts "\n📈 Plan de Rebalanceo:"
    balance_plan.each do |asset, adjustment|
      puts "#{asset}: #{adjustment > 0 ? '+' : ''}#{adjustment}%"
    end
  end
end