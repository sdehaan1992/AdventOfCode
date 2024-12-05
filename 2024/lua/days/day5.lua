local day5 = {}

local invalid_lines = {}
local order = {}

local function is_page_valid(pages, page_idx, order_table)
	local page_number = pages[page_idx]
	for i = page_idx, 1, -1 do
		local page_to_check = pages[i]
		if order_table[page_number] ~= nil then
			for _, value in pairs(order_table[page_number]) do
				if value == page_to_check then
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
	local result = 0
	if #invalid_lines == 0 then
		day5.part1(file)
	end
	for _, line in pairs(invalid_lines) do
		local pages = {}
		for page in string.gmatch(line, "%d+") do
			table.insert(pages, page)
		end
		local corrected_pages = {}
		local halfway = (#pages + 1) // 2
		while #corrected_pages ~= halfway do
			local page_to_check = table.remove(pages)
			local next = true
			for i = 1, #pages do
				if order[pages[i]] ~= nil then
					for _, value in pairs(order[pages[i]]) do
						if value == page_to_check then
							table.insert(pages, 1, page_to_check)
							next = false
							break
						end
					end
				end
				if next == false then
					break
				end
			end
			if next == true then
				table.insert(corrected_pages, page_to_check)
			end
		end

		result = result + corrected_pages[#corrected_pages]
	end

	return result
end

return day5
