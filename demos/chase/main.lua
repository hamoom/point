local point = require("point")

local text = display.newText("touch anywhere", display.contentCenterX, display.contentCenterY+30, native.systemFont, 16)

local rect = display.newRect(display.contentCenterX, display.contentCenterY, 20, 20)
rect:setFillColor(1,0,0)

local touchPoint = nil
local rectPoint = point.new(rect)

local speed = 2

local function touch(event)
	if event.phase == "began" then
		touchPoint = point.new(event)
	end
end

local function update()
	if touchPoint and rectPoint:distanceTo(touchPoint) > 1 then

		local vector = point.newFromSubtraction(touchPoint, rectPoint)
						:normalize()
						:multiply(speed)

		rect.x, rect.y = rectPoint:add(vector):getPosition()

	end
end


Runtime:addEventListener("touch", touch)
Runtime:addEventListener("enterFrame", update)