Room = Object:extend()
currentRoom = nil

function Room:new()
    self.areas = {}
end

function Room:addArea(area)
    if Mose.detect(self.areas, area) then return end
    table.insert(self.areas, area)
end

function Room:update(dt)
    for key, area in pairs(self.areas) do
        area:update(dt)
    end
end

function Room:draw()
    for key, area in pairs(self.areas) do
        area:update(dt)
    end
end

function goToRoom(roomType)
    currentRoom = _G[roomType]
end

squareRoom = Room()
goToRoom("squareRoom")
squareRoomArea = Area()