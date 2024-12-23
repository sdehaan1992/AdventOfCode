local day23 = {}

day23.part1 = function(file)
	local connections = {}
	local pcs = {}
	local input = io.open(file, 'r')
	for line in input:lines() do
		table.insert(connections, line)
		local left, right = string.match(line, '(%a+)-(%a+)')
		if not pcs[left] then
			pcs[left] = {}
		end
		if not pcs[right] then
			pcs[right] = {}
		end

		table.insert(pcs[left], right)
		table.insert(pcs[right], left)
	end

	local function startswith(text, begin)
		if string.sub(text, 1, #begin) == begin then
			return true
		else
			return false
		end
	end

	local parties = {}
	for _, connection in ipairs(connections) do
		local left, right = string.match(connection, '(%a+)-(%a+)')
		for pc, value in pairs(pcs) do
			local found_conns = 0
			for _, linked in ipairs(pcs[pc]) do
				if linked == left or linked == right then
					found_conns = found_conns + 1
				end
			end
			if found_conns == 2 then
				if startswith(left, 't') or startswith(right, 't') or startswith(pc, 't') then
					local test = { left, right, pc }
					table.sort(test)
					parties[test[1] .. test[2] .. test[3]] = 0
				end
			end
		end
	end

	local result = 0
	for _, _ in pairs(parties) do
		result = result + 1
	end

	return result
end

day23.part2 = function(file)
	local connections = {}
	local pcs = {}
	local input = io.open(file, 'r')
	for line in input:lines() do
		table.insert(connections, line)
		local left, right = string.match(line, '(%a+)-(%a+)')
		if not pcs[left] then
			pcs[left] = {}
		end
		if not pcs[right] then
			pcs[right] = {}
		end

		table.insert(pcs[left], right)
		table.insert(pcs[right], left)
	end

	local parties = {}
	for pc, links in pairs(pcs) do
		local lan = {}
		lan[pc] = 0
		for _, link in ipairs(links) do
			for _, link2 in ipairs(links) do
				if link ~= link2 then
					for _, innerlink in ipairs(pcs[link]) do
						if innerlink == link2 then
							lan[link] = 0
							lan[link2] = 0
							break
						end
					end
				end
			end
		end

		local party = {}
		for linked_pc, _ in pairs(lan) do
			table.insert(party, linked_pc)
		end
		table.sort(party)
		parties[table.concat(party, ',')] = (parties[table.concat(party, ',')] or 0) + 1
	end

	local highest_count = 0
	local largest_party = ""
	for party, count in pairs(parties) do
		if count > highest_count then
			highest_count = count
			largest_party = party
		end
	end

	return largest_party
end

return day23
