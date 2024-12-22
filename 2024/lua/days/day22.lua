local day22 = {}

day22.part1 = function(file)
	local input = io.open(file, 'r')

	local mix_and_prune = function(value, secret)
		return (value ~ secret) % 16777216
	end

	local result = 0
	for line in input:lines() do
		local start = tonumber(line)
		local curr = start
		for i = 1, 2000 do
			local pre = curr
			curr = curr * 64
			curr = mix_and_prune(curr, pre)
			pre = curr
			curr = curr // 32
			curr = mix_and_prune(curr, pre)
			pre = curr
			curr = curr * 2048
			curr = mix_and_prune(curr, pre)
		end
		result = result + curr
	end

	return result
end

day22.part2 = function(file)
	local input = io.open(file, 'r')

	local mix_and_prune = function(value, secret)
		return (value ~ secret) % 16777216
	end

	local get_price = function(secret)
		local _, change = math.modf(secret / 10)
		return math.tointeger(math.floor(change * 10 + 0.5))
	end

	local full_sequences = {}
	for line in input:lines() do
		local prices = {}
		local start = tonumber(line)
		table.insert(prices, { price = get_price(start), diff = nil })
		local curr = start
		for i = 1, 2000 do
			local pre = curr
			curr = curr * 64
			curr = mix_and_prune(curr, pre)
			pre = curr
			curr = curr // 32
			curr = mix_and_prune(curr, pre)
			pre = curr
			curr = curr * 2048
			curr = mix_and_prune(curr, pre)
			local new_price = get_price(curr)
			table.insert(prices, { price = new_price, diff = new_price - prices[#prices].price })
		end

		local curr_sequences = {}
		for i = 2, #prices - 3 do
			local key = tostring(prices[i].diff) ..
				tostring(prices[i + 1].diff) .. tostring(prices[i + 2].diff) .. tostring(prices[i + 3].diff)
			if not curr_sequences[key] then
				curr_sequences[key] = prices[i + 3].price
			end
		end

		for key, value in pairs(curr_sequences) do
			full_sequences[key] = (full_sequences[key] or 0) + value
		end
	end

	local max_value = 0
	for _, value in pairs(full_sequences) do
		if value > max_value then
			max_value = value
		end
	end

	return max_value
end

return day22
