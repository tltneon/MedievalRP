WEAPON_REQSKILLS = {}

-- Add Item Stat Requirements.
local function addRequire(itemID, reqAttribs)
	WEAPON_REQSKILLS[itemID] =  reqAttribs
end
-- addRequire("example", {gunskill = 3})

-- Adding Schema Specific Configs.
nut.config.setDefault("font", "Bitstream Vera Sans")

nut.config.add("wageInterval", 600, "The Interval of distrubution of salary money.", 
	function(oldValue, newValue)
		if (timer.Exists("nutSalary")) then
			timer.Adjust("nutSalary", newValue, 0, SCHEMA.SalaryPayload)
		end
	end, {
	data = {min = 10, max = 3600},
	category = "schema"
})

nut.config.add("incomeInterval", 600, "The Interval of player getting income from the bank money.", 
	function(oldValue, newValue)
		if (timer.Exists("nutBankIncome")) then
			timer.Adjust("nutBankIncome", newValue, 0, SCHEMA.BankIncomePayload)
		end
	end, {
	data = {min = 10, max = 3600},
	category = "schema"
})

nut.config.add("incomeRate", 1, "The Percentage Rate of Bank Income.", nil, {
	data = {min = 0, max = 100},
	category = "schema"
})

nut.config.add("dpBank", 10, "The Death Penalty: Hospital Cost (x% of Bank Reserve).", nil, {
	data = {min = 0, max = 100},
	category = "schema"
})

nut.config.add("bankFee", 5, "The Bank Transfer Fee (x% of Transfer Money).", nil, {
	data = {min = 0, max = 100},
	category = "schema"
})

nut.config.add("startMoney", 5, "Start money for new character.", nil, {
	data = {min = 0, max = 1000},
	category = "schema"
})