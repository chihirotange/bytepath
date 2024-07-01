function love.load()
    -- automatically load libs
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    -- logic
    circle1 = Circle(400, 400, 50)
end

function love.update(dt)
    --for my own convenient, so i don't have to touch the mouse ever
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    circle1:draw()
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