require 'rubygems'
require 'bundler/setup'
require 'watir'
require "io/console"
require 'json'

b = Watir::Browser.new:chrome
b.goto 'https://da.victoriabank.md/wb/'

b.text_field(name: 'login').set(STDIN.gets.chomp)
b.text_field(id: 'password').set(STDIN.noecho(&:gets).chomp)

b.button(value: "Login").click

b.wait_until{b.div(class: "block__main-menu").exists?}
sleep 5
divs = b.divs(class: "main-info")

account = []

divs.each do |div| 
  str = div.html   
  name = str[(str.index('class="name">')) + ('class="name">').size..str.index('</a>')-1]
  currency = str[(str.index('"currency-icon">') + ('"currency-icon">').size)..str.index("</div>")-1]
  balance = str[(str.index('class="amount">') + ('class="amount">').size)..str.index("</span>&nbsp")-1]  
  
  account.push({
	:name => name, 
	:balance => balance, 
	:courrency => currency,
	:nature => "check"
  })
end

account.each {|x| 
  puts "**Account**:"
  x.each_pair{|key,value| puts " -#{key}"}
}







