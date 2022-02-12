require "extended"
require "actor"
require "boxeffect"
require "poisonbox"

Bullet = {}

extended(Bullet, Actor)

Bullet.name = "bullet"

function Bullet:new(map, x, y, vx, vy, distanse, ownerId, damage)
    local self = Actor:new(map:getWorld(), x, y, "dynamic", love.physics.newCircleShape(5))
    local private = {}

        local body = self:getBody()
        body:applyForce(vx, vy)

        private.wayLength = 0

        private.oldX = x
        private.oldY = y
        private.damage = damage or 100
        
        private.ownerId = ownerId

    local public = {}

        function public:destroy()
            local body = self:getBody()
            local x, y = body:getPosition()
            body:destroy()

            map:addToCreationQueue(Poisonbox, map:getWorld(), x, y)

        end

        function public:getOwnerId()
            return private.ownerId
        end

        function public:draw()
            love.graphics.setColor(1, 0, 0)
            local body = self:getBody()
            local shape = self:getShape()
            if not body:isDestroyed() then
                love.graphics.circle("fill", body:getX(), body:getY(), shape:getRadius())
            end
        end

        function public:update(dt)
            local body = self:getBody()
            if not body:isDestroyed() then
                local x, y = body:getPosition()
                private.wayLength = private.wayLength + math.sqrt(math.pow(x - private.oldX, 2) + math.pow(y - private.oldY, 2))
                private.oldX = x
                private.oldY = y
                if private.wayLength > distanse then
                    self:destroy()
                end
            end
        end

        local userData = self:makeUserData()
        userData.type = "bullet"

        function callback(data)
            if data and (data.id == public:getOwnerId() or data.type == "sensor" or data.type == "bullet") then
                return
            end
            public:destroy()
        end
        userData.callback = callback
        userData.damage = private.damage

    setmetatable(public, self)
    self.__index = self; 


    return public
end
