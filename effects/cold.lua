require "extended"
require "effects/effect"

Cold = {}

extended(Cold, Effect)

function Cold:new(dps, duration)
    self = Effect:new(duration)
    local private = {}
        private.dps = dps
    local public = {}

    function public:tick(target)
        target:damage(dps)
    end


    setmetatable(public, self)
    self.__index = self; return public
end

