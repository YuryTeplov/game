Texture = {}

function Texture:new(imagefile, sx, sy, x, y)
    local private = {}
        sx = sx or 1000
        sy = sy or 1000
        private.x = x or 0
        private.y = y or 0
        private.image = love.graphics.newImage(imagefile)
        private.sx = sx / private.image:getWidth()
        private.sy = sy / private.image:getHeight()

        private.isDestroyed = false
    local public = {}

        function public:draw(x, y)
            x = x or private.x
            y = y or private.y
            love.graphics.scale(private.sx, private.sy)
            love.graphics.draw(private.image, x/private.sx, y/private.sy)
            love.graphics.scale(1/private.sx, 1/private.sy)
        end

        function public:setId(id)
            private.id = id
        end
        function public:getId()
            return private.id
        end

        function public:update(dt)

        end

        function public:destroy()
            private.isDestroyed = true
        end

        function public:isDestroyed()
            return private.isDestroyed
        end


    setmetatable(public, self)
    self.__index = self; return public
end
