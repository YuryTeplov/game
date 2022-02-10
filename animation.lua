Animation = {}

function Animation:new(imagefile, quadsx, quadsy, countOfAnimations, sx, sy, x, y)
    local private = {}
        sx = sx or 1000
        sy = sy or 1000
        private.x = x or 0
        private.y = y or 0
        private.image = love.graphics.newImage(imagefile)
        private.sx = (sx / private.image:getWidth()) * quadsx
        private.sy = (sy / private.image:getHeight()) * quadsy

        private.quadsList = {}

        private.currentAnimation = 1

        local quads = {}

        local height = private.image:getHeight()/quadsy
        local width = private.image:getWidth()/quadsx
        local quadsPerAnimation = (quadsx * quadsy)/countOfAnimations
        local animationsCounter = 0
        for y = 0, quadsy-1 do
            for x = 0, quadsx-1 do
                if animationsCounter >= quadsPerAnimation then
                    animationsCounter = 0
                    table.insert(private.quadsList, quads)
                    quads = {}
                end
                table.insert(quads, love.graphics.newQuad(x*width, y*height, width, height, private.image:getDimensions()))
                animationsCounter = animationsCounter + 1
            end
        end
        table.insert(private.quadsList, quads)

        private.duration = duration or 1
        private.currentTime = 0

        private.isDestroyed = false
    local public = {}

        function public:changeAnimation(animationNumber)
            if animationNumber <= 0 or animationNumber > #private.quadsList then
                --after making logger here will be a log
                return
            end

            private.currentAnimation = animationNumber

        end

        function public:draw(x, y)
            local spriteNum = math.floor(private.currentTime/private.duration * #private.quadsList[private.currentAnimation]) + 1
            x = x or private.x
            y = y or private.y
            love.graphics.scale(private.sx, private.sy)
            love.graphics.draw(private.image, private.quadsList[private.currentAnimation][spriteNum], x/private.sx, y/private.sy)
            love.graphics.scale(1/private.sx, 1/private.sy)
        end

        function public:setId(id)
            private.id = id
        end
        function public:getId()
            return private.id
        end

        function public:update(dt)
            private.currentTime = private.currentTime + dt
            if private.currentTime >= private.duration then
                private.currentTime = private.currentTime - private.duration
            end
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
