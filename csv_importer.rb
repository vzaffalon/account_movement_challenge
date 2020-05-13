# frozen_string_literal: true

require 'csv'
require 'redis'

@redis = nil
@accounts_csv = nil
@transactions_csv = nil
@parsed_accounts_csv = nil
@parsed_transactions_csv = nil

class String
    def is_number?
        true if Integer(self) rescue false
    end
end

def receive_args
  if ARGV[0].nil? || ARGV[1].nil?
    return puts '-- Error: Você precisa passar dois arquivos como parametro, o primeiro parâmetro deve ser um arquivo de contas e o segundo de transações'
  end
end

def create_redis_instance
  puts
  puts 'Instanciando redis..'
  @redis = Redis.new
  @redis.flushall
end

def open_csv_files
  puts
  puts 'Abrindo arquivos csv..'
  begin
    @accounts_csv = File.read(ARGV[0])
    @transactions_csv = File.read(ARGV[1])
  rescue => exception
      return  puts '-- Error: Programa não conseguiu ler os arquivos!'
  end
end

def parse_csvs
  puts
  puts 'Fazendo o parse dos arquivos csv..'
  begin
      # puts "accounts_csv" + accounts_csv
      @parsed_accounts_csv = CSV.parse(@accounts_csv, headers: false)
      @parsed_transactions_csv = CSV.parse(@transactions_csv, headers: false)
  rescue => exception
    return  puts '-- Error: Não conseguiu fazer o parse dos arquivos csv!'
  end
end

def create_accounts
  puts
  puts 'Criando contas..'
  @parsed_accounts_csv.each do |row|
      account_id = row[0]
      amount = row[1]
      if account_id and account_id.is_number? and amount and amount.is_number?
          account_exists = @redis.get(account_id)
          if !account_exists
            @redis.set(account_id, amount)
          else
            return  puts '-- Error: Csv mal formatado! Conta duplicada!'
          end
      else
          return  puts '-- Error: Csv mal formatado! Colunas devem ser números inteiros!'
      end
  end 
end

def create_transactions
  puts
  puts 'Criando transações..'
  @parsed_transactions_csv.each do |row|
    account_id = row[0]
    amount = row[1]
    if account_id and account_id.is_number? and amount and amount.is_number?
      account_exists = @redis.get(account_id)
      if account_exists
        @redis.set(account_id, amount)
      else
        return  puts '-- Error: Csv mal formatado! Colunas devem ser números inteiros!'
      end
    else
      return  puts '-- Error: Csv mal formatado! Colunas devem ser números inteiros!'
    end
    amount = amount.to_i
    current_amount = @redis.get(account_id).to_i
    current_amount += amount
    current_amount -= 300 if (current_amount < 0) && (amount > 0)
    @redis.set(account_id, current_amount.to_s)
  end
end

def output_result
  puts
  puts 'Resultado das transações:'
  puts
  @redis.keys.each do |key,value|
    puts 'id da conta:' + key
    puts "saldo final:" + @redis.get(key)
    puts
  end
end

receive_args()
create_redis_instance()
open_csv_files()
parse_csvs()
create_accounts()
create_transactions()
output_result()

