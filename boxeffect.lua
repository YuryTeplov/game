require "actor"
require "extended"

Boxeffect = {}

extended(Boxeffect, Actor)

function Boxeffect:new(world, posx, posy, sx, sy, duration)

    local private = {}

        private.lifetime = 0
        private.duration = duration or 1

        private.sx = sx or 100
        private.sy = sy or 100

    local self = Actor:new(world, posx, posy, "kinematic", love.physics.newRectangleShape(private.sx, private.sy))

        self:getFixture():setSensor(true)

    local public = {}

        function public:draw()
            local body = self:getBody()
            
            if not body:isDestroyed() then
                love.graphics.setColor(1, 0, 0, 0.5)
                local shape = self:getShape()
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
            end
        end

        function public:update(dt)
            if not self:isDestroyed() then
                private.lifetime = private.lifetime + dt
                if private.lifetime >= private.duration then
                    self:destroy()
                end
            end
        end

    local userData = self:makeUserData()
    userData.type = "sensor"
    function userData.callback(data)
    end


    setmetatable(public, self)
    self.__index = self; return public
end
