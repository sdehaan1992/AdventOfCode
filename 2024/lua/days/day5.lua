local day5 = {}

local invalid_lines = {}
local order = {}

local function is_page_valid(pages, page_idx, order_table, reorder)
	local page_number = pages[page_idx]
	for i = page_idx, 1, -1 do
		local page_to_check = pages[i]
		if order_table[page_number] ~= nil then
			for _, value in pairs(order_table[page_number]) do
				if value == page_to_check then
					if reorder then
						table.remove(pages, i)
						table.insert(pages, page_idx, value)
					end
					return false
				end
			end
		end
	end
	return true
end

day5.part1 = function(file)
	local local_file = io.open(file, "r")
	local result = 0
	local is_setup = true
	for line in local_file:lines() do
		if line == "" then
			is_setup = false
		end
		if is_setup then
			local sep_idx = string.find(line, "|", 1, true)
			local page = string.sub(line, 1, sep_idx - 1)
			local before = string.sub(line, sep_idx + 1)

			if order[page] == nil then
				order[page] = {}
			end

			table.insert(order[page], before)
		else
			local pages = {}
			for page in string.gmatch(line, "%d+") do
				table.insert(pages, page)
			end
			local is_valid = true
			local page_idx = 0
			for idx, _ in pairs(pages) do
				if not is_page_valid(pages, idx, order) then
					is_valid = false
					table.insert(invalid_lines, line)
					break
				end
			end

			if is_valid and #pages > 0 then
				result = result + (pages[(#pages + 1) // 2])
			end
		end
	end

	local_file:close()
	return result
end

day5.part2 = function(file)
	local correct_pages = {}
	local result = 0
	if #order == 0 then
		day5.part1(file)
	end
	for _, line in pairs(invalid_lines) do
		local is_valid = false
		local pages = {}
		for page in string.gmatch(line, "%d+") do
			table.insert(pages, page)
		end
		while not is_valid do
			for idx, _ in pairs(pages) do
				-- print("checking page " .. table.concat(pages, " "))
				is_valid = is_page_valid(pages, idx, order, true)
			end
		end
		table.insert(correct_pages, pages)
		result = result + (pages[(#pages + 1) // 2])
	end

	for key, value in pairs(correct_pages) do
		print("corrected page " ..
		invalid_lines[key] .. " TO ----------------- " .. table.concat(correct_pages[key], " "))
	end

	return result
end

return day5
