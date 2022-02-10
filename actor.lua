require "animation"

Actor = {}

function Actor:new(world, posx, posy, bodytype, shape, imagefile, size_image_x, size_image_y)
    local private = {}

        private.sx = size_image_x or 50
        private.sy = size_image_y or 100


        bodytype = bodytype or "static"
        private.body = love.physics.newBody(world, posx, posy, bodytype)
        private.shape = shape
        private.fixture = love.physics.newFixture(private.body, private.shape)
        private.userData = {}



    local public = {}

        function public:getSize()
            return private.sx, private.sy
        end

        if imagefile then
            private.texture = Animation:new(imagefile, 3, 4, 4, public:getSize())
        end


        function public:hasTexture()
            if private.texture then
                return true 
            else
                return false
            end
        end

        function public:drawTexture()
            local x, y = private.body:getPosition()
            local sx, sy = public:getSize()
            private.texture:draw(x-sx/2, y-sy/2)
        end
        
        function public:setId(id)
            private.userData.id = id
        end
        function public:getId()
            return private.userData.id
        end

        function public:isDestroyed()
            return private.body:isDestroyed()
        end

        function public:changeAnimation(animationNum)
            private.texture:changeAnimation(animationNum)
        end

        function public:destroy()
            private.body:destroy()
        end



        function public:getBody()
            return private.body
        end
        function public:getShape()
            return private.shape
        end
        function public:getFixture()
            return private.fixture
        end

        function public:getPosition()
            return private.body:getPosition()
        end

        function public:draw()
        end

        function public:load()
        end

        function public:update(dt)
            if private.texture then
                private.texture:update(dt)
            end
        end

        function public:makeUserData()
            return private.userData
        end

        private.fixture:setUserData(private.userData)

        public.old = public


    setmetatable(public, self)
    self.__index = self; return public
end
