function love.load()
    -- libraries
    Timer = require "libs.timer"
    -- automatically load libs
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    -- logic
    uberCircle = UberCircle(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 30, 150, 10)
    GlobalTimer = Timer()
    local handler_1 = GlobalTimer:after(1, function() print("hello") end)
    GlobalTimer:cancel(handler_1)
end

function love.update(dt)
    uberCircle:update(dt)

    GlobalTimer:update(dt)
    --for my own convenient, so i don't have to touch the mouse ever
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    uberCircle:draw()
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