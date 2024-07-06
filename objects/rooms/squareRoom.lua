squareRoom = Room()
squareRoomArea = squareRoom:createArea()
-- squareRoomArea:addGameObject("Circle", 100, 100, {radius = 50})
squareRoomArea:addGameObject("Square", 100, 100, {width = 50, height = 100})