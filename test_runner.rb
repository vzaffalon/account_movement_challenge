puts "Executando programa com arquivos de teste..."
puts
puts "**************************"
puts "Testando arquivo mal formatado..."
puts "**************************"
bad_format_test_output = `ruby csv_importer.rb ./accounts.csv ./bad_format.csv`

puts bad_format_test_output

puts
puts "**************************"
puts "Testando conta duplicada..."
puts "**************************"
puts
invalid_account_test_output = `ruby csv_importer.rb ./duplicate_account.csv ./transactions.csv`

puts invalid_account_test_output

puts
puts "**************************"
puts "Transação para conta invalida..."
puts "**************************"
puts
invalid_transaction_test_output = `ruby csv_importer.rb ./accounts.csv ./invalid_account_transaction.csv`

puts invalid_transaction_test_output

puts
puts "**************************"
puts "Csv de parse falho..."
puts "**************************"
puts
invalid_transaction_test_output = `ruby csv_importer.rb ./fail_parse.png ./transactions.csv`

puts invalid_transaction_test_output

puts
puts "**************************"
puts "Csv correto..."
puts "**************************"
puts
correct_test_output = `ruby csv_importer.rb ./accounts.csv ./transactions.csv`

puts correct_test_output