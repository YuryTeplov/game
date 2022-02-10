require "extended"
require "actor"

Mob = {}

extended(Mob, Actor)

function Mob:new(world, posx, posy, imagefile, hp, sx, sy, speed)
    local private = {}

        private.speed = speed or 3000

        sx = sx or 50
        sy = sy or 100

        local self = Actor:new(world, posx, posy, "dynamic", love.physics.newRectangleShape(sx, sy), imagefile, sx, sy)

        local body = self:getBody()
        body:setLinearDamping(5)
        body:setFixedRotation(true)

        private.health = hp or 1000

        private.effects = {}

        private.side = 1

    local public = {}


        function public:update(dt)
            self.old:update(dt)
            for k,v in pairs(private.effects) do
                if v:isDestroyed() then
                    self:purgeEffect(k)
                else
                    v:update(dt, self)
                end
            end
        end


        function public:draw()
            if not self:isDestroyed() then
                local body = self:getBody()
                local x1, y1 = self:getSize()
                local x, y = body:getPosition()
                if self:hasTexture() then
                    self:drawTexture()
                    love.graphics.print(private.health, x-x1/2, y-y1/2-30)
                else
                    local shape = self:getShape()
                    love.graphics.print(private.health, x-x1/2, y-y1/2-30)
                    love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
                end
            end
        end

        function public:changeSide(side)
            private.side = side
            self:changeAnimation(side)
        end


        function public:move_left()
            self:getBody():applyForce(-private.speed, 0)
            public:changeSide(2)
        end
        function public:move_right()
            self:getBody():applyForce(private.speed, 0)
            public:changeSide(1)
        end
        function public:move_top()
            self:getBody():applyForce(0, -private.speed)
            public:changeSide(3)
        end
        function public:move_bottom()
            self:getBody():applyForce(0, private.speed)
            public:changeSide(4)
        end

        function public:damage(x)
            private.health = private.health - x
            if private.health <= 0 then
                self:destroy()
            end
        end

        function public:purgeEffect(id)
            private.effects[id] = nil
        end

        function public:purge()
            private.effects = nil
        end

        function public:addEffect(effect)
            table.insert(private.effects, effect)
        end

    setmetatable(public, self)
    self.__index = self; 

    local userData = self:makeUserData()
    userData.type = "mob"
    function userData.callback(data)
    end

    function userData.addEffect(effect)
        public:addEffect(effect)
    end

    return public
end
