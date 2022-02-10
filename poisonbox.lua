require "boxeffect"
require "extended"
require "poison"

Poisonbox = {}

extended(Poisonbox, Boxeffect)

function Poisonbox:new(world, posx, posy, sx, sy, duration)

    local private = {}

    self = Boxeffect:new(world, posx, posy, sx, sy, duration)

    local public = {}


    local userData = self:makeUserData()
    function userData.callback(data)
        if data and data.type == "mob" then
            data.addEffect(Poison:new(50, 10))
        end
    end


    setmetatable(public, self)
    self.__index = self; return public
end
