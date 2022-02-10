require "extended"
require "mob"

Enemy = {}

extended(Enemy, Mob)

function Enemy:new(map, posx, posy)
    local self = Mob:new(map:getWorld(), posx, posy)

    local private = {}

    local public = {}

    local userData = self:makeUserData()

    function userData.callback(data)
        if data.type == "bullet" then
            public:damage(data.damage)
        end
    end

    setmetatable(public, self)
    self.__index = self; return public
end
