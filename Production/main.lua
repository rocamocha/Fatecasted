-- default package paths
local version = _VERSION:match('%d+%.%d+')
package.path = 'modules/share/lua/' .. version .. '/?.lua;' .. 'modules/?.lua;' .. package.path
package.cpath = 'modules/lib/lua/' .. version .. '/?.so;' .. package.cpath

PRODUCTION = false --> when untrue, export to the test directory
DEBUG = false 

local serpent = require('serpent')
local tsv2t = require('tsv2t')
local sandwich = require('sandwich')
local fatecasted = require('fatecasted')

-- sleep
local function sleep(a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end

-- pretty print
-- TO-DO: accept multiple arguments (...)
local function pprint(t)
    print(serpent.block(t))
end

-- console print tool
local last_str = ''
local function iop(str)
    io.write(('\b \b'):rep(#last_str))  -- erase old line
    io.write(str)                       -- write new line
    io.flush()
    last_str = str
 end

local console = {}
-- dump card data

function console.character(card)
    local keys = { --> ordered keys
        'code',
        'title',
        'type',
        'rarity',
        'bp',
        'realize',
        'cost1','ability1',
        'cost2','ability2',
        'cost3','ability3',
        'img'
    }
    for _, k in ipairs(keys) do
        local row = k
        row = k:sub(1,7) == 'ability' and 'ablt'.. k:sub(8) or row
        row = k:sub(1,6) == 'rarity' and 'rrty' or row
        row = k:sub(1,7) == 'realize' and 'dstny' or row
        print(string.upper(row) .. ': ', card[k] and card[k] or '-')
    end
end

function console.fate(card, type)
    local keys = { --> ordered keys
        'code',
        'title',
        'effect',
        'lv0', 'lv1', 'lv2',
        'crystallized'
    }
    for _, k in ipairs(keys) do
        local function log_tbl_val(label)
            print(string.upper(label) .. ': ', card[k] and card[k] or '-')
        end

        local row = k
        row = k:sub(1,6) == 'effect' and 'fx'.. k:sub(8) or row
        row = k:sub(1,12) == 'crystallized' and 'cryst' or row

        if type ~= 'layered' then
            if k:sub(1,2) ~= 'lv' then
                log_tbl_val(row)
            end
        elseif k:sub(1,6) ~= 'effect' then
            log_tbl_val(row)
        end
    end
end

-- generator container
local generate = {}

-- generate character card (html)
---------------------------------------------------------------------------------------------------
function generate.character(card, config)
    local html = {
        sandwich = sandwich.html(),
        {
            sandwich = sandwich.head(),
            [[<link rel='stylesheet' href='../css/character.css'>]],
            [[<link rel='stylesheet' href='../fonts/eczar-fontfacekit/web fonts/eczar_regular_macroman/stylesheet.css'>]]
        },
        {
            sandwich = sandwich.div({class='card'}),
            fatecasted.character.image(card),
            {
                sandwich = sandwich.div({class='gradient-overlay'})
            },
            fatecasted.character.rarity(card),
            fatecasted.character.title(card),
            fatecasted.character.code(card, config),
            fatecasted.character.type(card),
            {
                sandwich = sandwich.div({class='content'}),
                fatecasted.character.breakpoint(card),
                fatecasted.character.abilities(card, config)
            }
        }
    }
    
    if DEBUG then
        print('===============================================================')
        print('Generating character card (summon) html using data:\n')
        console.character(card)
    end

    return sandwich.compile(html)
end

-- generate fate card (html)
---------------------------------------------------------------------------------------------------
function generate.fate(card, config)
    assert(config.type, 'Fate type was not configured!')

    local css = {
        sandwich = sandwich.head(),
        [[<link rel='stylesheet' href='../css/fate.css'>]],
        [[<link rel='stylesheet' href='../fonts/eczar-fontfacekit/web fonts/eczar_regular_macroman/stylesheet.css'>]]
    }
    
    local fate = {
        sandwich = sandwich.html(), css,
        {
            sandwich = sandwich.div({class='card'}),
            fatecasted.fate.image(card),
            {
                sandwich = sandwich.div({class='gradient-overlay'})
            },
            fatecasted.fate.title(card),
            fatecasted.fate.code(card, config),
            fatecasted.fate.type(card),
            {
                sandwich = sandwich.div({class='content'}),
                fatecasted.fate.effects[config.type](card)
            }
        }
    }

    if DEBUG then
        print('===============================================================')
        print('Generating fate card ('.. config.type ..') html using data:\n')
        console.fate(card, config.type)
    end
    
    return sandwich.compile(fate)
end


-- export a card set
---------------------------------------------------------------------------------------------------
local function export(data, generator, config)
    local directory = PRODUCTION and 'cards/markup' or 'cards/test'

    local function write_card_to_html(filename, i)
        local file = io.open(filename, 'w')
        local header = '<!DOCTYPE html>\n'
        if file then
            file:write(header .. generator(data[i], config))
            file:close()
        end
    end

    local function progress_bar(p, f)
        local progress = (p/f)*10
        local string = '[\27[32m'
        for i = 1, 20 do
            if i <= progress*2 then
                string = string .. '|'
            else
                string = string .. ' '
            end
        end
        return string .. '\27[0m]'
    end

    if generator == generate.character then
        for i = 1, #data do
            iop('Generating ' .. #data .. ' cards '..progress_bar(i, #data)..' from set \27[93mC'..config.set..'\27[0m ('..config.side..') --> \27[32m' .. i .. '\27[0m of \27[32m' .. #data .. '\27[0m complete.')
            write_card_to_html(directory .. '/C' .. config.set .. '-' .. data[i].code .. '-' .. config.side .. '.html', i)
        end
        print('\n')
        io.flush()
    end

    if generator == generate.fate then
        for i = 1, #data do
            iop('Generating ' .. #data .. ' cards '..progress_bar(i, #data)..' from set \27[93mF'..config.set..'\27[0m ('..string.upper(config.type)..') --> \27[32m' .. i .. '\27[0m of \27[32m' .. #data .. '\27[0m complete.')
            write_card_to_html(directory .. '/F' .. config.set .. '-' .. data[i].code .. '.html', i)
        end
        print('\n')
        io.flush()
    end
end

---------------------------------------------------------------------------------------------------
local function export_character_card_set(set)
    export(tsv2t('sheets/C'..set..' - SUMMON.tsv'), generate.character, { set = set, side = 'F' })
    export(tsv2t('sheets/C'..set..' - DESTINY.tsv'), generate.character, { set = set, side = 'D' })
end

local function export_fate_card_set(set)
    export(tsv2t('sheets/F'..set..' - VARIABLE.tsv'), generate.fate, { set = set, type = 'variable'})
    export(tsv2t('sheets/F'..set..' - FIXED.tsv'), generate.fate, { set = set, type = 'fixed'})
    export(tsv2t('sheets/F'..set..' - LAYERED.tsv'), generate.fate, { set = set, type = 'layered'})
end

local userinput = {}

function userinput.get(config)
    userinput.last = io.read()

    if config.restrict then
        local input_is_valid = false
        
        for _, valid in pairs(config.restrict) do
            if userinput.last == valid then
                input_is_valid = true
            end
            
            if not config.case_sens then
                if string.upper(userinput.last) == string.upper(valid) then
                    input_is_valid = true
                end
            end
        end

        if not input_is_valid then
            print('Invalid input!')
            print('You typed: ' .. userinput.last)
            userinput.get(config)
        end
    end
end

-- invokes the callback function when userinput matches
---------------------------------------------------------------------------------------------------
function userinput.select(match, callback, case_sens)
    local input = userinput.last
    
    if not case_sens then
        match = string.upper(match)
        input = string.upper(userinput.last)
    end
        
    if type(match) == 'string' then
        if input == match then callback() end
    elseif type(match) == 'table' then
        for _, v in pairs(match) do
            if input == v then callback() end
        end
    end
end


io.write('What type of cards do you want to generate?\n')
io.write('Type [c/f] for character / fate: ')
io.flush()
userinput.get({ restrict = {'C', 'F'} })

userinput.select('C', function()
    local set = nil
    io.write('\nWhich character card set\'s data should be used?\n')

    while type(set) ~= 'number' do
        io.write('Type a number (#): ')
        set = io.read("*n")
    end

    io.write('\n')
    export_character_card_set(set)
end, false)

userinput.select('F', function()
    local set = nil
    io.write('\nWhich fate card set\'s data should be used?\n')

    while type(set) ~= 'number' do
        io.write('Type a number (#): ')
        set = io.read("*n")
    end

    io.write('\n')
    export_fate_card_set(set)
end, false)

io.write('\nProcess completed.\n')