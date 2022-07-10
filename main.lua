require "interface"
require "texture"
require "map"
require "wall"
require "hero"
require "camera"
require "enemy"
require "dropitem"
require "bullets/bullet"

function love.load()
    map = Map:new()
    map:load()

    ground = Texture:new("ground.jpeg", 2000, 2000, 0, 0)
    map:addObject(ground)

    wall = Wall:new(map:getWorld(), 1000, 5, 2000, 10)
    map:addObject(wall)

    wall = Wall:new(map:getWorld(), 5, 1000, 10, 2000)
    map:addObject(wall)

    wall = Wall:new(map:getWorld(), 2000, 1000, 10, 2000)
    map:addObject(wall)

    wall = Wall:new(map:getWorld(), 1000, 2000, 2000, 10)
    map:addObject(wall)

    hero = Hero:new(map, 200, 200, "hero.jpg")
    map:addObject(hero)

    enemy = Enemy:new(map, 430, 430)
    map:addObject(enemy)

    dropitem = Dropitem:new(map:getWorld(), 500, 500, "purple.png", Bullet, 5)
    map:addObject(dropitem)

    interfaceFont = love.graphics.newFont(20)

    interface = Interface:new(interfaceFont)
    interface:setHero(hero)
    
    map:setTargetForCamera(hero)





end

function love.draw()
    if hero:isDestroyed() then return end
    love.graphics.setColor(1, 1, 1)
    map:draw()
    interface:draw()
end

function love.update(dt)
    if hero:isDestroyed() then return end

    map:update(dt)
    if love.keyboard.isDown("d") then
        hero:move_right()
    elseif love.keyboard.isDown("a") then
        hero:move_left()
    end

    if love.keyboard.isDown("w") then
        hero:move_top()
    elseif love.keyboard.isDown("s") then
        hero:move_bottom()
    end


end

function love.keypressed(key)
    if key == "up" then
        hero:hit_top()
    elseif key == "left" then
        hero:hit_left()
    elseif key == "right" then
        hero:hit_right()
    elseif key == "down" then
        hero:hit_bottom()
    elseif key == "e" then
        hero:touchItem()
    end
end
