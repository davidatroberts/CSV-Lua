local CSV = {}

local string = require('std.string')

function CSV.read(file_path, sep) 
	sep = sep or ','

	local file = assert(io.open(file_path),
		'Invalid file')

	-- read csv into raw table
	local csv_tbl = {}
	for line in file:lines() do
		table.insert(csv_tbl, line)
	end

	-- cancel if nothing in table
	if #csv_tbl < 1 then
		return nil, 'No data in csv'
	end

	-- put into formatted table
	local parsed_tbl = {}

	-- add headers
	local headers = string.split(csv_tbl[1], sep)
	for _, header in ipairs(headers) do
		parsed_tbl[header] = {}
	end

	-- return if nothing else in csv
	if #csv_tbl < 2 then
		return parsed_tbl
	end

	-- go through add values to table
	for i=2, #csv_tbl do
		local line = csv_tbl[i]
		local values = string.split(line, sep)

		for i, value in ipairs(values) do
			table.insert(parsed_tbl[headers[i]], value)
		end
	end

	return parsed_tbl
end


function CSV.write(tbl, tbl_index, file_path, sep)
	sep = sep or ','

	-- open the file
	local file = assert(io.open(file_path, 'w'))

	-- write the headers
	local header_str = table.concat(tbl_index, sep)
	file:write(string.format('%s\n', header_str))

	-- iterate through each row
	for i=1, #tbl[tbl_index[1]] do
		-- get all the values in the row
		-- according to the order of the tbl_index
		local line = {}
		for _, column in ipairs(tbl_index) do
			local value = tbl[column][i]
			table.insert(line, tostring(value))
		end

		-- output the row
		local line_str = table.concat(line, sep)
		file:write(string.format('%s\n', line_str))
	end

	file:close()
end

return CSV