Interface = {}

function Interface:new(font)
    local private = {}
        private.font = font

        -- loading images

        private.health_icon = love.graphics.newImage("health_icon.png")

    local public = {}

    function public:setHero(hero)
        private.hero = hero
        private.windowx, private.windowy = love.graphics.getDimensions()
    end

    function public:draw()
        if private.hero then
            -- set big interface font
            love.graphics.setFont(private.font)

            local hp = private.hero:getHealth()
            love.graphics.setColor(1, 1, 1)

            -- draw heart icon
            --
            love.graphics.push()
            love.graphics.scale(0.02, 0.02)

            love.graphics.draw(private.health_icon, 20 * (1/0.02), 20 * (1/0.02))

            love.graphics.pop()

            love.graphics.print(hp, 50, 20)

            -- back to default font
            love.graphics.setNewFont(14)

            local backpack = private.hero:getBackpack()
            for k, v in pairs(backpack) do
                love.graphics.print(v.item.name.." : "..v.count, private.windowx - 100, private.windowy - 100 - 20*k)
            end
        end
    end

    function public:update(dt)
    end

    setmetatable(public, self)
    self.__index = self; return public
end
