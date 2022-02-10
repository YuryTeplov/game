require "actor"
require "extended"

Wall = {}

extended(Wall, Actor)

function Wall:new(world, posx, posy, sizex, sizey)
    local private = {}

        local self = Actor:new(world, posx, posy, "static", love.physics.newRectangleShape(sizex, sizey))

    local public = {}

        function public:draw()
            local body = self:getBody()
            local shape = self:getShape()
            love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
        end


    setmetatable(public, self)
    self.__index = self; return public
end
