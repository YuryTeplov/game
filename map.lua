Map = {}


function Map:new()
    local private = {}
        
        private.objects = {}
        love.physics.setMeter(64)
        private.world = love.physics.newWorld(0, 0, true)


        private.creationQueue = {}

        private.camera = Camera:new()

    local public = {}

        function public:setTargetForCamera(target)
            private.camera:setTarget(target)
        end
        
        function beginContact(a, b, coll)
            adata = a:getUserData()
            bdata = b:getUserData()
            if adata and adata.callback then
                adata.callback(bdata)
            end
            if bdata and bdata.callback then
                bdata.callback(adata)
            end
        end

        function endContact(a, b, coll)
        end

        function preSolve(a, b, coll)
        end
        
        function postSolve(a, b, coll, normalimpulse, tangentimpulse)
        end

        function public:addToCreationQueue(class, ...)
            local obj = {}
            obj.class = class
            obj.args = {...}
            table.insert(private.creationQueue, obj)
        end

        private.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

        function public:addObject(obj)
            table.insert(private.objects, obj)
            local id = #private.objects
            obj:setId(#private.objects)
        end

        function public:getWorld()
            return private.world
        end

        function public:draw()
            private.camera:set()
            for k, i in pairs(private.objects) do
                i:draw()
            end
            private.camera:unset()
        end

        function public:load()
            
        end

        function public:update(dt)

            --[[
            for k,v in pairs(private.objects) do
                print(k, v)
            end
            --]]
            
            private.world:update(dt)

            local deleteQueue = {}

            for k, i in pairs(private.objects) do
                if i:isDestroyed() then
                    table.insert(deleteQueue, k)
                else
                    i:update(dt)
                end
            end

            for k, i in pairs(deleteQueue) do
                private.objects[i] = private.objects[#private.objects]
                table.remove(private.objects)
            end
            
            for k, i in pairs(private.creationQueue) do
                public:addObject(i.class:new(unpack(i.args)))
            end
            private.creationQueue = {}
        end

    setmetatable(public, self)
    self.__index = self; return public

end
