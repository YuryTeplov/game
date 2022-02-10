Camera = {}

function Camera:new(mapx, mapy)

    local private = {}
        private.x = 0
        private.y = 0
        private.scaleX = 1
        private.scaleY = 1
        private.rotation = 0

        private.mapx = mapx or 2000
        private.mapy = mapy or 2000



    local public = {}
        function public:set()

            if private.target and not private.target:getBody():isDestroyed() then
                private.x, private.y = private.target:getPosition()
                private.x = private.x - love.graphics.getPixelWidth()/2
                private.y = private.y - love.graphics.getPixelHeight()/2
                if private.x < 0 then
                    private.x = 0
                end
                if private.y < 0 then
                    private.y = 0
                end

                local wx, wy = love.graphics.getWidth(), love.graphics.getHeight()

                if private.x > private.mapx - wx then
                    private.x = private.mapx - wx
                end
                if private.y > private.mapy - wy then
                    private.y = private.mapy - wy
                end

            end
            
            love.graphics.push()
            love.graphics.rotate(-private.rotation)
            love.graphics.scale(1/private.scaleX, 1/private.scaleY)
            love.graphics.translate(-private.x, -private.y)
        end

        function public:unset()
            love.graphics.pop()
        end

        function public:setTarget(target)
            private.target = target or private.target
        end

        function public:move(dx, dy)
            private.x = private.x + (dx or 0)
            private.y = private.y + (dy or 0)
        end

        function public:rotate(dr)
            private.rotation = private.rotation + dr
        end

        function public:scale(sx, sy)
            sx = sx or 1
            private.scaleX = private.scaleX * sx
            private.scaleY = private.scaleY * (sy or sx)
        end

        function public:setPosition(x, y)
            private.x = x or private.x
            private.y = y or private.y
        end

        function public:setScale(sx, sy)
            private.scaleX = sx or private.scaleX
            private.scaleY = sy or private.scaleY
        end

        function public:mousePosition()
            return love.mouse.getX() * private.scaleX + private.x, love.mouse.getY() * private.scaleY + private.y
        end

    setmetatable(public, self)
    self.__index = self; return public
end

