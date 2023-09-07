-- helper function that parses .tsv and returns a lua table
local function tsv2t(filename)
    local lines = io.lines(filename)
    local first_line = lines() 
    local fields = {} -- list of keys
    local rawdata = {} -- card data without keys
    local data = {} -- output

    for v in first_line:gmatch("[^\t]+") do
        table.insert(fields, string.lower(v))
    end

    for ln in lines do
        local card = {}
        for v in ln:gmatch("[^\t]+") do
            card[#card + 1] = (v ~= '\13') and v or nil
        end
        table.insert(rawdata, card)
    end

    for _, c in ipairs(rawdata) do
        local combine = {}
        for i, v in ipairs(fields) do
            combine[v] = c[i]
        end
        table.insert(data, combine)
    end

    return data
end

return tsv2t