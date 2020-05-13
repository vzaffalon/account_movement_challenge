# frozen_string_literal: true

require 'csv'
require 'redis'

if ARGV[0].nil? || ARGV[1].nil?
  return puts '-- Error: Você precisa passar dois arquivos como parametro, o primeiro parâmetro deve ser um arquivo de contas e o segundo de transações'
end

redis = Redis.new
begin
contas_csv = File.read(ARGV[0])
transacoes_csv = File.read(ARGV[1])
rescue => exception
    return  puts '-- Error: Programa não conseguiu ler os arquivos!'
end

    csv = CSV.parse(contas_csv, headers: false)
    csv.each do |row|
      account_id = row[0]
      amount = row[1]
      redis.set(account_id, amount)
    end 



csv = CSV.parse(transacoes_csv, headers: false)
csv.each do |row|
  account_id = row[0]
  amount = row[1].to_i
  current_amount = redis.get(account_id).to_i
  puts current_amount
  current_amount += amount
  puts current_amount
  # puts amount
  current_amount -= 300 if (current_amount < 0) && (amount > 0)
  redis.set(account_id, current_amount.to_s)
end

redis.keys.each do |key|
  puts 'id da conta:' + key
  # puts "saldo final:"
end
