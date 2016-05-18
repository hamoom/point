#  point
2d Math Library for Corona SDK / Lua

Point is a 2d math library for Corona SDK or just plain ol' lua.  It allows us to think of positions within corona as single units (points) vs independent x and y coordinates.

**This is how we'd move an object along a vector without point library.**

```lua 
local speed = 5
local angle = 90
local angleRad = (math.pi * angle) / 180
local normalizedX = math.cos(angleRad)
local normalizedY =	math.sin(angleRad)

-- move object
obj.x = obj.x + (speed*normalizedX)
obj.y = obj.y + (speed*normalizedY)
```

**With the point library.**
```lua
local speed = 5
local angle = 90

-- move object
local vector = point.newFromAng(90):multiply(speed)
obj.x, obj.y = point.newFromAddition(obj, vector):getPosition()
```

## For examples check out the demo folder.  For full documentation look at the wiki.
