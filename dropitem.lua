require "extended"
require "actor"
Dropitem = {}

extended(Dropitem, Actor)

function Dropitem:new(world, posx, posy, imagefile, itemclass, count)

    self = Actor.new(self, world, posx, posy, "static", love.physics.newCircleShape(30), imagefile, 60, 60)
    self:getFixture():setSensor(true)

    local private = {}

    local public = {}

    local userData = self:makeUserData()

    userData.type = "item"
    userData.items = {itemclass = itemclass, count = count}

    function userData.take()
        self:destroy()
    end

    setmetatable(public, self)
    self.__index = self; return public
end
