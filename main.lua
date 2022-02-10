require "texture"
require "map"
require "wall"
require "hero"
require "camera"
require "enemy"

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



    camera = Camera:new()
    camera:setTarget(hero)


end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    camera:set()
    map:draw()
    camera:unset()
end

function love.update(dt)
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
    end
end
