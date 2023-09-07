# Sandwich!
Sandwich is a simple html generator based in lua that outputs an html string with human readable indentation, compiled from a lua table. The idea comes from conceptualizing certain html tags as 'sandwiches', where the opening `<>` and closing `</>` tags are the 'bread' of the sandwich.

## Structure of a Sandwich...
Your generated html is a sandwich, described by a lua table. To start your sandwich, first we choose the bread. This is done by specifying the opening and close tag to be used. You can do this by assigning the return of the `tag()` function to the key `sandwich` of your lua table.

```lua
local sandwich = require('sandwich')

local html = {
    sandwich = sandwich.tag('html')
}
```
...will output:
```html
<html>
</html>
```

Sandwich is also equipped with predefined html tags. Using these can improve readability in your code, and speed up your workflow.

```lua
local html = {
    sandwich = sandwich.html()
}
```

The above snippet is functionally the same as the one earlier, where we used `tag()` instead.

<div style="page-break-after: always;"></div>

## Adding layers to your sandwich...
You can add more layers to your sandwich by nesting lua tables or even values.
```lua
local html = {
    sandwich = sandwich.html(),
    {
        sandwich = sandwich.div(),
            'I\'m in a div!'
    },
    'I\'m between two divs!',
    {
        sandwich = sandwich.div(),
            'I\'m the other div!'
    }
}
```
...outputs to:
```html
<html>
    <div>
        I'm in a div!
    </div>
    I'm between two divs!
    <div>
        I'm the other div!
    </div>
</html>
```

## Seasoning and dressing your sandwich...
Attributes can be added to your html tags by passing a lua table into the `tag()` functions.
```lua
sandwich.tag('div', {class='myclass'})
sandwich.div({class='myclass'})
```
Both of the above options will result with the opening tag: `<div class='myclass'>`

# Compile your... sandwich?
To generate the html string from your lua table, use the `compile()` function.
```lua
sandwich.compile(t)
```