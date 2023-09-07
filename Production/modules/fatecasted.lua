local sandwich = require('sandwich')
local utils = require('utils')

--------------------------------------------------------------
-- helper module for card html generation using [sandwich.lua]
--------------------------------------------------------------


-- public instance
local fatecasted = {}

local function character_color(card)
    local red = {'Striker','Destroyer','Hunter'}
    local blue = {'Protector','Guardian','Aegis'}
    local green = {'Mystic','Magician','Traveler'}
    local purple = {'Trickster','Wildcard'}
    local yellow = {'Creator','Deity'}
    
    for color, set in pairs({
        red = red, 
        blue = blue,
        green = green,
        purple = purple,
        yellow = yellow
    }) do
        for _, type in pairs(set) do
            if card.type == type then
                return color
            end
        end
    end
end

-- references to icon graphics (.svg)
fatecasted.icons = {}
for _, icon in ipairs({
    'heart',
    'swords','shield','flame',
    'sparkle',
    'refresh-cw'
}) do
    fatecasted.icons[icon] = utils.file_read('./icons/'..icon..'.svg')
end

-------------------------------------------------------------------
fatecasted.character = {} -- container for character card-gen tools
-------------------------------------------------------------------

function fatecasted.character.image(card)
    -- use a placeholder image when none is provided
    local placeholder = '../../109650424_p0.jpg'
    local img = card.image and card.image or placeholder

    return {
        sandwich = sandwich.img({class='main',src=img})
    }
end

function fatecasted.character.rarity(card)
    return {
        sandwich = sandwich.div({class='rarity'})
    }
end

function fatecasted.character.title(card)
    return { 
        sandwich = sandwich.div({class='title'}),
            {
                sandwich = sandwich.div({class='block top ' .. character_color(card)}),
                {
                    sandwich = sandwich.h1(),
                        card.title
                }
            }
    }
end

function fatecasted.character.breakpoint(card)
    return {
        sandwich = sandwich.div({class='breakpoint'}),
            fatecasted.icons['heart'] .. ' ' .. card.bp
    }
end

function fatecasted.character.type(card)
    return {
        sandwich = sandwich.div({class='type'}),
            card.type
    }
end

function fatecasted.character.code(card, config)
    return {
        sandwich = sandwich.div({class='code'}),
        {
            sandwich = sandwich.div({class='block bottom ' .. character_color(card)}),
                {
                    sandwich = sandwich.p(),
                        'C' .. config.set .. '-' .. card.code .. '-' .. config.side
                }
        }
    }
end

function fatecasted.character.abilities(card, config)

    -- iconify ability cost
    local function ablt_cost(card)
        local ablt_costs = {}

        local function icon(char)
            local icons = {
                ['P'] = 'refresh-cw',
                ['A'] = 'swords',
                ['D'] = 'shield',
                ['M'] = 'flame',
                [':'] = 'gem'
            }
            
            for k, icon_name in pairs(icons) do
                if char == k then
                    return utils.file_read('./icons/'..icon_name..'.svg')
                end
            end

            return ''
        end

        for i = 1, 3 do
            if card['ability'..i] then
                local str = card['cost'..i] -- original str of cost
                local cost_icons = '' -- iconified cost

                for cursor = 1, #str do
                    local char = str:sub(cursor, cursor) -- traversal through cost string
                    local append = icon(char) -- parse characters of string

                    if char == ':' then
                        local ct = '' -- initialize string for crystal charge count

                        for c = cursor + 1, #str do
                            local ch = str:sub(c,c) -- traversal
                            ct = ch ~= ' ' and ct..ch or ct -- extraction
                        end

                        if ct ~= '0' then
                            cost_icons = cost_icons .. '<div class="variable-cost">' .. append .. '<p>'..ct..'</p></div>'
                        end
                    else
                        cost_icons = cost_icons .. append
                    end
                end

                ablt_costs[i] = cost_icons
            end
        end

        return ablt_costs
    end

    -- create <abilities> tag
    local abilities = {
        sandwich = sandwich.div({class='abilities'})
    }

    -- handle destiny ability first
    if config.side == 'D' then
        table.insert(abilities, {
            sandwich = sandwich.div({class='ability destiny'}),
            {
                sandwich = sandwich.div({class='cost'}),
                utils.file_read('./icons/sparkle.svg'),
                {
                    sandwich = sandwich.p({class='destiny-text'}),
                    'Destiny'
                }
            }
        })
        if not (card.realize == '-') then
            table.insert(abilities, {
                sandwich = sandwich.div({class='ability'}),
                {
                    sandwich = sandwich.div({class='cost'}),
                    utils.file_read('./icons/arrow-big-up-dash.svg')
                },
                {
                    sandwich = sandwich.p(),
                    card.realize
                }
            })
        end
    end
    
    -- insert each <ability> into <abilities>
    for i = 1, 3 do
        if card['ability'..i] then
            table.insert(abilities, {
                sandwich = sandwich.div({class='ability'}),
                {
                    sandwich = sandwich.div({class='cost'}),
                    ablt_cost(card)[i]
                },
                {
                    sandwich = sandwich.p(),
                    card['ability'..i]
                }
            })
        end
    end

    return abilities
end

------------------------------------
--  /:===]   /\    _|-|_  /:===]
--  :|      //\\  |_---_| :|
--  :|==]  //==\\   |-|   :|=]
--  :|    //'  '\\  |-|   :|
--  :|   //'    '\\ |-|   :|===]
------------------------------------

----------------------------------------------------------------
fatecasted.fate = {} -- container for fate card generation tools
----------------------------------------------------------------

function fatecasted.fate.image(card)
    -- use a placeholder image when none is provided
    local placeholder = '../../109650424_p0.jpg'
    local img = card.image and card.image or placeholder

    return {
        sandwich = sandwich.img({class='main',src=img})
    }
end

function fatecasted.fate.title(card)
    return { 
        sandwich = sandwich.div({class='title'}),
            {
                sandwich = sandwich.div({class='block top'}),
                {
                    sandwich = sandwich.h1(),
                        card.title
                }
            }
    }
end

function fatecasted.fate.code(card, config)

    return {
        sandwich = sandwich.div({class='code'}),
        {
            sandwich = sandwich.div({class='block bottom'}),
                {
                    sandwich = sandwich.p(),
                        'F' .. config.set .. '-' .. card.code
                }
        }
    }
end

function fatecasted.fate.type(card)
    return {
        sandwich = sandwich.div({class='type'}),
            'Fate'
    }
end

fatecasted.fate.effects = { -- container for effect layouts by fate type
    variable = function(card)
        return {
            sandwich = sandwich.div({class='effects'}),
            {
                sandwich = sandwich.div({class='effect'}),
                {
                    sandwich = sandwich.p(),
                    card.effect
                }
            },
            {
                sandwich = sandwich.div({class='effect'}),
                {
                    sandwich = sandwich.div({class='crystallized'}),
                    'Crystallize' .. utils.file_read('./icons/gem.svg')
                },
                {
                    sandwich = sandwich.p(),
                    card.crystallized
                }
            }
        }
    end,

    fixed = function(card)
        return {
            sandwich = sandwich.div({class='effects'}),
            {
                sandwich = sandwich.div({class='effect'}),
                {
                    sandwich = sandwich.p(),
                    card.effect
                }
            },
            {
                sandwich = sandwich.div({class='effect'}),
                {
                    sandwich = sandwich.div({class='crystallized'}),
                    'Crystallize' .. utils.file_read('./icons/gem.svg')
                },
                {
                    sandwich = sandwich.p(),
                    card.crystallized
                }
            }
        }
    end,

    layered = function(card)
        local effects = {
            sandwich = sandwich.div({class='effects'})
        }

        for _, lv in ipairs({'lv0','lv1','lv2'}) do
            if card[lv] and card[lv] ~= 'n/a' then
                table.insert(effects, {
                    sandwich = sandwich.div({class='effect'}),
                    {
                        sandwich = sandwich.div({class='level'}),
                        'Lv. '..string.sub(lv, 3)
                    },
                    {
                        sandwich = sandwich.p(),
                        card[lv]
                    }
                })
            end
        end

        if card.crystallized then
            table.insert(effects, {
                sandwich = sandwich.div({class='effect'}),
                {
                    sandwich = sandwich.div({class='crystallized'}),
                    'Crystallize' .. utils.file_read('./icons/gem.svg')
                },
                {
                    sandwich = sandwich.p(),
                    card.crystallized
                }
            })
        end

        return effects
    end
}

return fatecasted