Object = require "libs.classic"
require "objects.circle"
require "objects.square"
require "objects.area"
require "libs.utils"

Timer = require "libs.timer"
Mose = require "libs.mose"
Input = require "libs.input"
Camera = require "libs.camera"

function love.load()
    -- automatically load libs
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    -- logic
    GlobalInput = Input() 
    GlobalInput:bind('3', function() GlobalCamera:shake(4, 60, 0.3) end)
    love.graphics.setDefaultFilter("nearest")
    love.graphics.setLineStyle("rough")
    
    MainCanvas = love.graphics.newCanvas(gw, gh)
    GlobalCamera = Camera()
    resize(3)
    --test room
    MainRoom = Room()
    MainRoomArea = MainRoom:createArea() 
    goToRoom("MainRoom")
    MainRoomArea:addGameObject("Circle", gw/2, gh/2, {radius = 20})

end

function love.update(dt)
    GlobalCamera:update(dt)
    GlobalCamera.smoother = Camera.smooth.damped(5)
    GlobalCamera:lockPosition(dt, gw/2, gh/2)
    if currentRoom then currentRoom:update(dt) end
    
    --for my own convenient, so i don't have to touch the mouse ever
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love:draw()
    love.graphics.setCanvas(MainCanvas) 
    love.graphics.clear()
    GlobalCamera:attach(0, 0, gw, gh)
    if currentRoom then currentRoom:draw() end
    GlobalCamera:detach()
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(MainCanvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode("alpha")
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

function resize(s)
    love.window.setMode(s*gw, s*gh)
    sx, sy = s, s
end