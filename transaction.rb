class Transaction

def initialize#(strin)
	@date = ""
	@description = ""
	@amount = ""
end

def getValueofTransaction(strin)
	arrReturn = []
	str_1 = "<div class=\"day-header\">"
	str_2 = "</div>"
	str_3 = "<span class=\"history-item-time\">"
	str_4 = "</span>"
	str_5 = "class=\"history-item-state\" title=\""
	str_6 = "\" data-category"
	str_7 = "<span class=\"amount\">"	

	data = strin[(strin.index(str_1)+str_1.size)..strin.index(str_2)-1]
	time = strin[(strin.index(str_3)+str_3.size)..strin.index(str_4)-1]
	strin_1 = strin[(strin.index(str_4)+str_4.size)..-1]
	@description = strin_1[(strin_1.index(str_5)+str_5.size)..(strin_1.index(str_6)-1)]
	strin_2 = strin_1[(strin_1.index(str_7)+str_7.size)..-1] 	
	@amount = strin_2[0..strin_2.index(str_4)-1]

	@date = "#{Time.now.strftime("%Y")}-#{data}T#{time}Z"	
	my_object = [{  :date => "#{@date}",:description => "#{@description}",
				:amount => "#{@amount}"}]				

	return my_object
end

end