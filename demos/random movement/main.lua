local point = require("point")

local speed = 5

-- setup rect and point based on that rect
local rect = display.newRect(display.contentCenterX, display.contentCenterY, 20, 20)
rect:setFillColor(1,0,0)
local rectPoint = point.new(rect)

-- setup waypoint and set waypointrect's position to the waypoints position
local wayPoint = point.new(math.random(0, display.contentWidth), math.random(0, display.contentHeight))
local wayPointRect = display.newRect(0,0,5,5)
wayPointRect.x, wayPointRect.y = wayPoint:getPosition()
wayPointRect:setFillColor(0,1,0)


local function update()
	-- if we're far away from waypoint go to it
	if rectPoint:distanceTo(wayPoint) > 5 then
		local vector = point.newFromSubtraction(wayPoint, rectPoint)
						:normalize()
						:multiply(speed)

		rect.x, rect.y = rectPoint:add(vector):getPosition()

	-- otherwise we reset our waypoint
	else 
		wayPoint:setPosition(math.random(0, display.contentWidth), math.random(0, display.contentHeight))
		wayPointRect.x, wayPointRect.y = wayPoint:getPosition()
	end
end

Runtime:addEventListener("enterFrame", update)