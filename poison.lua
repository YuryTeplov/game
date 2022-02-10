require "extended"
require "effect"

Poison = {}

extended(Poison, Effect)

function Poison:new(dps, duration)
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

