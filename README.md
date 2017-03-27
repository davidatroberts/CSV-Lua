# CSV-Lua
Lua library for easily reading/writing CSV files

### Requirements:
```stdlib```

### Reading:
```lua
local csv = require('csv')

local csv_file = csv.read(file_path)
local column = csv_file['Header1']

-- get the first value in column Header1
local value = column[1]
```

### Writing:
```lua
local csv = require('csv')

-- used to control the order in which the headers are output
local column_index = {
	'Header1', 'Header2', 'Header3', 'Header4'
}

-- columns, keys must match column index
local columns = {
	Header1 = {'something here', 'another thing'},
	Header2 = {'a', 'b'},
	Header3 = {1, 2},
	Header4 = {'and another', 'here'}
}

csv.write(columns, column_index, 'output.csv')
```

### Options
```lua
-- second argument sets separator between values
-- default is comma

local csv = require('csv')

-- separate on space
local csv_file = csv.read(file_path, ' ')
```
