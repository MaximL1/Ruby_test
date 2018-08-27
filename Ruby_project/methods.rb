def getAccounts(strin)		
	indexName_0 = strin.index('#contracts') 
	nameStr = strin[indexName_0+11..indexName_0+100]
	indexName_1 = nameStr.index('title="')
	name_1_Str = nameStr[indexName_1+7..nameStr.size-1]
	indexName_2 = name_1_Str.index('"')
	name = name_1_Str[0..indexName_2-1]	
	return name

end

def getBalance(strin)
	indexBalance_1 = strin.index('primary-balance') 
	balanceStr = strin[indexBalance_1+38..indexBalance_1+100]
	indexBalance_2 = balanceStr.index('</span')
	balance = balanceStr[0..indexBalance_2-1]	
	return balance
end
def getCurrency(strin)
	
	 indexCurrency_1 = strin.index('amount currency')
	 currencyStr = strin[indexCurrency_1+21..indexCurrency_1+100]
	 indexCurrency_2 = currencyStr.index('</span')
	 currency = currencyStr[0..indexCurrency_2-1]
	 return currency
end