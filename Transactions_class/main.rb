require 'rubygems'
require 'bundler/setup'
require 'watir'
require "io/console"
require 'json'
require './transactionClass'

b = Watir::Browser.new:chrome
b.goto 'https://da.victoriabank.md/wb/'

b.text_field(name: 'login').set(STDIN.gets.chomp)
b.text_field(id: 'password').set(STDIN.noecho(&:gets).chomp)

b.button(value: "Login").click

b.wait_until{b.div(class: "block__main-menu").exists?}
sleep 2
# transaction defoult return transaction per 1 month
puts "Transaction defoult 1 month"
acc = Transactions.new #by default period: '1' - month  account_name: 'all'

data = acc.getTransaction(b)

puts JSON.pretty_generate(data)
# transaction of  2 month
puts "Transaction  of  2 month"
acc = Transactions.new(period: '2') #by default period: '1' - month  account_name: 'all'

data = acc.getTransaction(b)

puts JSON.pretty_generate(data)
