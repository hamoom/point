local point = require("point")

local text = display.newText("touch anywhere", display.contentCenterX, display.contentCenterY+30, native.systemFont, 16)

-- setup missile and point based on that missile
local missile = display.newRect(display.contentCenterX, display.contentCenterY, 20, 10)
missile:setFillColor(1,0,0)
local missilePoint = point.new(missile)

-- setup target
local target = display.newRect(0,0,10,10)
target:setFillColor(0,1,0)
target.isVisible = false

local rotationSpeed = 10
local speed = 5
local curAngle, offsetAngle = nil, nil


local function sign(num)
    return num < 0 and -1 or 1
end

local function update()
    if target.isVisible then
        if not curAngle then
            curAngle = point.newFromSubtraction(target, missile):angle()
        end
        offsetAngle = point.newFromSubtraction(target, missile):angle()

        local differenceAngle = point.shortestAngleBetween(curAngle, offsetAngle)
        local amtToRotate = rotationSpeed 

        if math.abs(differenceAngle) < amtToRotate then
            amtToRotate = math.abs(differenceAngle)
        end

        amtToRotate = -sign(differenceAngle) * amtToRotate
        curAngle = curAngle + amtToRotate

        local vector = point.newFromAng(curAngle):multiply(speed)   
        missile.x, missile.y = point.newFromAddition(missile, vector):getPosition()
        missile.rotation = point.new(vector):angle()
    end
end

local function touch(event)
    if event.phase == "began" then
        target.isVisible = true
        target.x, target.y = event.x, event.y
    elseif event.phase == "moved" then
        target.x, target.y = event.x, event.y
    end
end

Runtime:addEventListener("touch", touch)
Runtime:addEventListener("enterFrame", update)