Object = require "libs.classic"
Timer = require "libs.timer"
Mose = require "libs.mose"
Input = require "libs.input"
require "objects.circle"
require "objects.square"
require "objects.area"
require "libs.utils"

function love.load()
    -- automatically load libs
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    -- logic
    GlobalInput = Input() 
    GlobalInput:bind("1", function() goToRoom("squareRoom") end)
    GlobalInput:bind("2", function() goToRoom("circleRoom") end)
end

function love.update(dt)
    
    if currentRoom then currentRoom:update(dt) end

    --for my own convenient, so i don't have to touch the mouse ever
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    if currentRoom then currentRoom:draw() end
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