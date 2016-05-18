local point = {}
local point_mt = { __index = point }

local function createXAndY(arg)
    local x,y
    if arg.n == 1 then
        local val = arg[1]
        if type(arg[1]) == "number" then
            x,y = val, val
        else
            local obj = arg[1]
            x,y = val.x, val.y
        end
    elseif arg.n == 2 then
        x,y = arg[1], arg[2]
    else 
        error("incorrect parameter count")
    end
    return x,y
end

local function createXandYNonMut(arg)
    local x1,y1,x2,y2
    if arg.n == 2 then
        x1,y1 = arg[1].x, arg[1].y
        x2,y2 = arg[2].x, arg[2].y   
    elseif arg.n == 4 then
        x1,y1 = arg[1], arg[2]
        x2,y2 = arg[3], arg[4]
    else
        error("incorrect parameter count")
    end
    return x1,y1,x2,y2
end

function point.new(...)
    local x,y = createXAndY(arg)
    local thisPoint = {x=x, y=y}
    return setmetatable(thisPoint, point_mt)
end

function point.newFromAng(angle)
    local angle = (math.pi * angle) / 180
    return point.newFromAngRad(angle)
end

function point.newFromAngRad(angle)
    local thisPoint = {x=math.cos(angle), y=math.sin(angle)}
    return point.new(thisPoint)
end


function point.newFromAddition(...)
    local x1,y1,x2,y2 = createXandYNonMut(arg)

    return point.new(x1+x2, y1+y2)
end

function point.newFromSubtraction(...)
    local x1,y1,x2,y2 = createXandYNonMut(arg)
    return point.new(x1-x2, y1-y2)
end

function point.newFromMultiplication(...)
    local x1,y1,x2,y2 = createXandYNonMut(arg)
    return point.new(x1*x2, y1*y2)
end

function point.newFromDivision(...)
    local x1,y1,x2,y2 = createXandYNonMut(arg)
    return point.new(x1/x2, y1/y2)
end

function point:add(...)
    local x,y = createXAndY(arg)
    self.x = self.x + x
    self.y = self.y + y
    return self
end

function point:subtract(...)
    local x,y = createXAndY(arg)
    self.x = self.x - x
    self.y = self.y - y
    return self
end

function point:multiply(...)
    local x,y = createXAndY(arg)
    self.x = self.x * x
    self.y = self.y * y
    return self
end

function point:divide(...)
    local x,y = createXAndY(arg)
    self.x = self.x / x
    self.y = self.y / y
    return self
end

function point:length()
    return math.sqrt((self.x*self.x) + (self.y*self.y))
end

function point:normalize()
    local tempPoint = self:normalized()
    self.x, self.y = tempPoint.x, tempPoint.y
    return self
end

function point:normalized()
    local length = self:length()
    if length > 0 then
        return self:divide(length, length)
    else
        return self:setPosition(0,0)
    end
end

function point:rounded()
    return self:setPosition(math.round(self.x), math.round(self.y))
end

function point:distanceTo(...)
    local x,y = createXAndY(arg)
    local tempPoint = point.new(self.x-x, self.y-y)
    return tempPoint:length()
end

function point:angleRad()
    return math.atan2(self.y, self.x)
end

function point:angle()
    return self:angleRad() * 180 / math.pi
end

function point:print()
    print("x: " .. self.x .. " y: " .. self.y)
end

function point:getPosition()
    return self.x, self.y
end

function point:getPositionRounded()
    return math.round(self.x), math.round(self.y)
end

function point:setPosition(...)
    self.x, self.y = createXAndY(arg) 
    return self
end

function point.shortestAngleBetween(target, source)
   local a = target - source
   
   if (a > 180) then
      a = a - 360
   elseif (a < -180) then
      a = a + 360
   end
   
   return a
end

return point


