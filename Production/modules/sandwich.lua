-- tag based html generation with lua tables
local sandwich = {}

function sandwich.tag(tag, attributes)
    assert(tag and type(tag) == 'string', '[sandwich]: Tag is missing!')

    return {
        open = (function()
            if not attributes then 
                return '<'..tag..'>'
            else
                local attr = ''
                for k, v in pairs(attributes) do
                    attr = attr .. ' ' .. k ..'=\'' .. v .. '\''
                end
                
                if tag == 'img' then
                    return '<'..tag..attr..' />'
                end

                return '<'..tag..attr..'>'
            end
        end)(),
        
        close = '</'..tag..'>'
    }
end

function sandwich.compile(html, ilv) 
    local ilv = ilv and ilv or 0

    local function indent(n)
        if n > 0 then
            local tabstring = ''
            
            for i = 1, n do
                tabstring = tabstring..'\t'
            end
            
            return tabstring
        else
            return ''
        end
    end

    local children = ''
    for _, v in ipairs(html) do
        children = children .. (v.sandwich and sandwich.compile(v, ilv + 1) or indent(ilv + 1).. v .. '\n')
    end
 
    if html.sandwich.open:sub(2,4) == 'img' then
        return indent(ilv) .. html.sandwich.open .. '\n'
    end

    return
        indent(ilv) .. html.sandwich.open
            .. indent(ilv) .. '\n' .. children
        .. indent(ilv) .. html.sandwich.close .. '\n'
end

-- define all tags
for _, v in ipairs({
    'html',
    'head',
    'div',
    'h1',
    'p',
    'img',
    'svg'
}) do
    sandwich[v] = function(attr)
        return sandwich.tag(v, attr)
    end
end

return sandwich