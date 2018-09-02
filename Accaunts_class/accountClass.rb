require 'rubygems'
require 'watir'
require 'json'

class Accounts
   
  def initialize(b)
    @b = b     
  end

  def getAccount
    divs = @b.divs(class: "main-info")

    data = {
      Account: []
    }

    divs.each do |div| 
      str = div.html 
        
      name = str[(str.index('class="name">')) + ('class="name">').size..str.index('</a>') - 1]
      currency = str[(str.index('"currency-icon">') + ('"currency-icon">').size)..str.index("</div>") - 1]
      balance = str[(str.index('class="amount">') + ('class="amount">').size)..str.index("</span>&nbsp") - 1]  
  
      data[:Account].push({
        :name => name, 
        :balance => balance, 
        :currency => currency,
        :nature => "check"
      })
    end
    
    return data        
  end
end

