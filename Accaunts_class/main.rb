require 'rubygems'
require 'bundler/setup'
require 'watir'
require "io/console"
require 'json'
require './accountClass'

b = Watir::Browser.new:chrome
b.goto 'https://da.victoriabank.md/wb/'

b.text_field(name: 'login').set(STDIN.gets.chomp)
b.text_field(id: 'password').set(STDIN.noecho(&:gets).chomp)

b.button(value: "Login").click

b.wait_until{b.div(class: "block__main-menu").exists?}
sleep 5

acc = Accounts.new(b)

data = acc.getAccount

puts JSON.pretty_generate(data)