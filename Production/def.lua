-- default package paths
local version = _VERSION:match('%d+%.%d+')
package.path = 'modules/share/lua/' .. version .. '/?.lua;' .. 'modules/?.lua;' .. package.path
package.cpath = 'modules/lib/lua/' .. version .. '/?.so;' .. package.cpath
