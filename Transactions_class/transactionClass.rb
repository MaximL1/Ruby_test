require 'rubygems'
require 'watir'
require 'json'

class Transactions
  attr_accessor :period, :account_name

  def initialize(params = {})  	
    @period = params.fetch(:period, '1')
    @account_name = params.fetch(:account_name, 'all')
  end

  def getTransaction(b)
	b.a(href: /CP_HISTORY/).click
	b.wait_until{b.input(class: ["filter-date", "from", "maxDateToday", "hasDatepicker"]).exists?}

	if @period != '1'	
	  b.input(class: ["filter-date", "from", "maxDateToday", "hasDatepicker"]).click
	  	  
	  for x in 1..@period.to_i - 1 do
	    b.link(class:  ["ui-datepicker-prev", "ui-corner-all"]).click
	  end
    
	  date_now = Time.now.strftime("%d").to_i
		
	  if b.link(text: "#{date_now}").exist? 
	    b.link(text: "#{date_now}").click
	  else	  	
	  	b.link(text: "#{date_now - 1}").click
	  end
	end	

	if @account_name != 'all'	  
	  b.div(class: "arrow").click	  
	  b.span(class: "contract-name", text: "#{@account_name}").click
	end

	sleep 2		

	hash_month = {"January" => "01", "February" => "02", "March" => "03", "April" => "04",
				  "May" => "05", "June" => "06", "July" => "07", "August" => "08", 
				  "September" => "09", "October" => "10", "November" => "11", "December" => "12",}
	data = {
      transaction: []
    }

	count = 0
	year = ''
	month = ''
	day = ''
	houre = ''
	description = ''
	amount = ''
		
	b.divs(class: "operations").each do |div|
	  str = div.text

	  str.each_line do |elem|	    	
		if elem =~ /(?<mh>\w+) (?<ya>\d+)($)/	  
	  	  m = elem.match /(?<mh>\w+) (?<ya>\d+)($)/		
  	      year = m[:ya]
  	      month = hash_month[m[:mh]]
  	    end
  
        if count == 3
  	      date = "#{year}-#{month}-#{day.gsub("\n","")}T#{houre.gsub("\n","")}Z"  	      
	      data[:transaction].push({
            :date => date, 
            :description => description.gsub("\n",""), 
            :amount => amount
          })  
          count = 0   
        end
         
        if elem =~ /(\d{2})(...[a-z])($)/
  	      day = elem.gsub!(/\s+\w+/, '')  	
  	      next
        end

        if elem =~ /(\d{2})(\:)(\d{2})($)/
  	      houre = elem
  	      count += 1
  	      next
        end

        if count == 1
  	      description = elem
  	      count += 1
  	      next
        end

        if count == 2
  	      amount = elem.gsub!(/([a-zA-Z])/, '')
  	      amount = amount.gsub!(/\s+/, '')
  	      count += 1
  	      next
        end
	  end		
	end
	 	
    return data
  end   
end

