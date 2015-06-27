-- This file contains all commands and chat types of Modern RP Schema.

nut.command.add("bankdeposit", {
	syntax = "<amount>",
	onRun = function(client, arguments)
		local atmEntity
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:isBank()) then
				atmEntity = v
				break
			end
		end

		if (IsValid(atmEntity) and hook.Run("CanUseBank", client, atmEntity)) then
			local amount = tonumber(table.concat(arguments, ""))
			local char = client:getChar()

			if (amount and amount > 0 and char) then
				amount = math.Round(amount)
				if (char:hasMoney(amount)) then
					char:addReserve(amount)
					char:takeMoney(amount)
					client:notify(L("depositMoney", client, nut.currency.get(amount)))
				else
					client:notify(L("cantAfford", client))
				end
			else
				client:notify(L("provideValidNumber", client))
			end
		end
	end
})

nut.command.add("bankwithdraw", {
	syntax = "<amount>",
	onRun = function(client, arguments)
		local atmEntity
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:isBank()) then
				atmEntity = v
				break
			end
		end

		if (IsValid(atmEntity) and hook.Run("CanUseBank", client, atmEntity)) then
			local amount = tonumber(table.concat(arguments, ""))
			local char = client:getChar()

			if (amount and isnumber(amount) and amount > 0 and char) then
				amount = math.Round(tonumber(amount))

				if (char:hasReserve(amount)) then
					char:takeReserve(amount)
					char:giveMoney(amount)
					client:notify(L("withdrawMoney", client, nut.currency.get(amount)))
				else
					client:notify(L("cantAfford", client))
				end
			else
				client:notify(L("provideValidNumber", client))
			end
		end
	end
})

nut.command.add("banktransfer", {
	syntax = "<amount>",
	onRun = function(client, arguments)
		local atmEntity
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:isBank()) then
				atmEntity = v
				break
			end
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			if (IsValid(atmEntity) and hook.Run("CanUseBank", client, atmEntity)) then
				local amount = table.concat(arguments, "")
				local char = client:getChar()
				local tChar = target:getChar()
				amount = math.Round(tonumber(amount))

				if (char == tChar) then
					client:notify(L("sameChar", client))
					return
				end

				if (amount and isnumber(amount) and amount > 0 and char) then
					if (char:hasReserve(amount)) then
						tChar:addReserve(amount*.95)
						char:takeReserve(amount)
					end
				else
					client:notify(L("provideValidNumber", client))
				end
			end
		end
	end
})

nut.command.add("banklongtransfer", {
	syntax = "<amount>",
	onRun = function(client, arguments)
		local atmEntity
		for k, v in ipairs(ents.FindInSphere(client:GetPos(), 128)) do
			if (v:isBank()) then
				atmEntity = v
				break
			end
		end

		if (IsValid(atmEntity) and hook.Run("CanUseBank", client, atmEntity)) then
			local amount = table.concat(arguments, "")
			local char = client:getChar()
			amount = math.Round(tonumber(amount))

			if (amount and isnumber(amount) and amount > 0 and char) then
				if (char:hasReserve(amount)) then
					-- Fee 10%
				end
			else
				client:notify(L("provideValidNumber", client))
			end
		end
	end
})
