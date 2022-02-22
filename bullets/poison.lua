require "extended"
require "bullets/bullet"
require "poisonbox"

PoisonBullet = {}

extended(PoisonBullet, Bullet)

PoisonBullet.name = "poison bullet"

function PoisonBullet:new(map, x, y, vx, vy, distanse, ownerId)
    local self = Bullet:new(map, x, y, vx, vy, distanse, ownerId, 100, Poisonbox)

    local private = {}

    local public = {}

    setmetatable(public, self)
    self.__index = self; 

    return public
end
