Effect = {}

function Effect:new(duration)
    local private = {}
        private.duration = duration or 10
        private.lifetime = 0
        private.tickcounter = 0
        private.isDestroyed = false
    local public = {}


    function public:destroy()
        private.isDestroyed = true
    end

    function public:isDestroyed()
        return private.isDestroyed
    end

    function public:tick()
    end

    function public:update(dt, target)
        private.lifetime = private.lifetime + dt
        if private.lifetime / 1 > private.tickcounter then
            self:tick(target)
            private.tickcounter = private.tickcounter + 1
        end
        if private.lifetime > private.duration then
            self:destroy()
        end
    end


    setmetatable(public, self)
    self.__index = self; return public
end
