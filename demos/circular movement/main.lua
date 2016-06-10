local point = require("point")
local angle = 0
local radius = 100
local rotationSpeed = 5

-- setup rect and point based on that rect
local rect = display.newRect(display.contentCenterX, display.contentCenterY, 20, 20)
rect:setFillColor(1,0,0)
local rectPoint = point.new(rect)

local function update()
    angle = angle + rotationSpeed
    
    local pointFromAngle = point.newFromAng(angle)
                                :multiply(radius)

    rect.x, rect.y = point.newFromAddition(rectPoint, pointFromAngle):getPosition()
end

Runtime:addEventListener("enterFrame", update)