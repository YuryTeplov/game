require "extended"
require "mob"
require "bullet"
require "gun"

Hero = {}

extended(Hero, Mob)

function Hero:new(map, posx, posy, imagefile)
    local self = Mob:new(map:getWorld(), posx, posy, imagefile)
    local private = {}
        
        private.gun = Gun:new(Bullet)

        private.backpack = {}

    local public = {}

        function public:addItem(itemClass, count)
            for k, v in pairs(private.backpack) do
                if v.item == itemClass then
                    v.count = v.count + count
                    return
                end
            end
            table.insert(private.backpack, {item= itemClass, count= count})
        end

        function public:setBullets(id)
            private.gun:setBullets(private.backpack[id])
        end

        public:addItem(Bullet, 10)
        public:setBullets(1)


        
        
        function private:hit(x, y, vx, vy)
            private.gun:hit(x, y, vx, vy, self:getId(), map)
        end

        private.bulletSpeed = 500





        function public:hit_left()
            local x, y = self:getPosition()
            local x1, y1 = self:getSize()
            private.hit(self, x-x1/2, y, -private.bulletSpeed, 0)
        end
        function public:hit_right()
            local x, y = self:getPosition()
            local x1, y1 = self:getSize()
            private.hit(self, x+x1/2, y, private.bulletSpeed, 0)
        end
        function public:hit_top()
            local x, y = self:getPosition()
            local x1, y1 = self:getSize()
            private.hit(self, x, y-y1/2, 0, -private.bulletSpeed)
        end
        function public:hit_bottom()
            local x, y = self:getPosition()
            local x1, y1 = self:getSize()
            private.hit(self, x, y+y1/2, 0, private.bulletSpeed)
        end

        function public:touchItem()
            local contacts = self:getBody():getContacts()           
            for k, i in pairs(contacts) do
                local fix1, fix2 = i:getFixtures()
                local data1 = fix1:getUserData()
                local data2 = fix2:getUserData()
                if data1 and data1.type == "item" then
                    public:addItem(data1.items.itemclass, data1.items.count)
                    data1.take()
                    break
                end
                if data2 and data2.type == "item" then
                    public:addItem(data2.items.itemclass, data2.items.count)
                    data2.take()
                    break
                end
            end
        end

        function public:getBackpack()
            return private.backpack
        end

    setmetatable(public, self)
    self.__index = self; return public
end
