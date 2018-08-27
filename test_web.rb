require 'rubygems'
require 'bundler/setup'
require 'watir'
require "io/console"
require 'json'
require './methods'
require './Transaction'

b = Watir::Browser.new:chrome

b.goto 'https://da.victoriabank.md/wb/'

puts "Write a UserName\n    and Password"

user = STDIN.gets.chomp
pass = STDIN.noecho(&:gets).chomp
#if b.div(class: ["page-message", "error"]).exist?
#$
#end

b.text_field(name: 'login').set(user)
b.text_field(id: 'password').set(pass)

b.button(value: "Login").click
#sleep 1
b.div(class: "block__main-menu").exists?

b.wait_until{b.div(class: "block__main-menu").exists?}

@myStr = b.html

name = getAccounts(@myStr)
balance = getBalance(@myStr)
currency = getCurrency(@myStr)

b.a(href: /#contracts/).click

b.wait_until{b.div(class: /contract-info/).exists?}
b.a(href: "#contract-history").click

sleep 2

b.input(class: ["filter-date", "from", "maxDateToday", "hasDatepicker"]).click

sleep 2

time = Time.now.strftime("%d/%m/%Y")
month = time.split(?/)[1]
data = time.split(?/)[0]


b.a(class:  ["ui-datepicker-prev", "ui-corner-all"]).click
#b.a(class:  "ui-datepicker-prev ui-corner-all").click

b.link(text: "#{data}").click
sleep 5

@to_json = b.div(class: "day-operations", :index => 1)
var_transaction = @to_json.html

 transac = Transaction.new#(var_transaction)
 obj_transaction =  transac.getValueofTransaction(var_transaction)

my_object = { :accaounts => [{ :name => "#{name}",:balance => "#{balance}",
				:currency => "#{currency}",:nature => "checking", :transaction => obj_transaction } ] }
puts JSON.pretty_generate(my_object)
