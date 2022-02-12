Interface = {}

function Interface:new()
    local private = {}
    local public = {}

    function public:setHero(hero)
        private.hero = hero
        private.windowx, private.windowy = love.graphics.getDimensions()
    end

    function public:draw()
        if private.hero then
            local hp = private.hero:getHealth()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(hp, 100, private.windowy - 100)

            local backpack = private.hero:getBackpack()
            for k, v in pairs(backpack) do
                love.graphics.print(v.item.name.." : "..v.count, 100, 100 + 20*k)
            end
        end
    end

    function public:update(dt)
    end

    setmetatable(public, self)
    self.__index = self; return public
end
