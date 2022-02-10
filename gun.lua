Gun = {}

function Gun:new()

    local private = {}

        private.bullets = nil

    local public = {}

        function public:setBullets(item)
            private.bullets = item
        end

        function public:hit(x, y, vx, vy, id, map)
            if private.bullets and private.bullets.count > 0 then
                map:addObject(private.bullets.item:new(map, x, y, vx, vy, 500, id, 500))
                private.bullets.count = private.bullets.count - 1
            end
        end

        function public:draw()
            
        end

    setmetatable(public, self)
    self.__index = self; return public
end
