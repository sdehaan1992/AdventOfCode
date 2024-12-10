local benchmark = {}

benchmark.run = function(f, ...)
	local before = os.clock()
	local result = table.pack(f(...))
	local after = os.clock()

	local duration = after - before
	local unit
	if duration < 0.001 then
		unit = "microsceconds"
		duration = duration * 1000000
	elseif duration < 1 then
		unit = "milliseconds"
		duration = duration * 1000
	else
		unit = "seconds"
	end

	return duration, unit, table.unpack(result)
end

return benchmark
