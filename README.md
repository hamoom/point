#  point
2d Math Library for Corona SDK / Lua

Point is a 2d math library for Corona SDK or just plain ol' lua.  It allows us to think of positions within corona as single units (points) vs independent x and y coordinates.

**This is how we'd move an object along a vector without point library.**

```lua 
obj.x = 85
obj.y = 100
local speed = 5
local length = math.sqrt((obj.x*obj.x) + (obj.y*obj.y))
local normalizedX = obj.x / length
local normalizedY	obj.y / length

-- move object
obj.x = obj.x + (speed * normalizedX)
obj.y = obj.y + (speed * normalizedY)
```

**With the point library.**
```lua
obj.x = 85
obj.y = 100
local speed = 5

-- create a point table based on objects position
local point = p.new(obj)
obj.x, obj.y = point:normalize():multiply(speed):getPosition()
```

