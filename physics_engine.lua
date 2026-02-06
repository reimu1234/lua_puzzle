-- Physics Engine Implementation for Collision Detection, Snap Forces, Gravity, and Boundary Constraints

local PhysicsEngine = {}

-- Gravity setting
PhysicsEngine.gravity = {x = 0, y = -9.81}

-- Object data structure
PhysicsEngine.objects = {}

-- Function to add object
function PhysicsEngine:addObject(object)
    table.insert(self.objects, object)
end

-- Function for collision detection
function PhysicsEngine:collisionDetection()
    for i = 1, #self.objects do
        for j = i + 1, #self.objects do
            if self:checkCollision(self.objects[i], self.objects[j]) then
                self:resolveCollision(self.objects[i], self.objects[j])
            end
        end
    end
end

-- Function to check collision between two objects
function PhysicsEngine:checkCollision(obj1, obj2)
    -- Simple AABB (Axis-Aligned Bounding Box) collision detection
    return obj1.x < obj2.x + obj2.width and 
           obj1.x + obj1.width > obj2.x and 
           obj1.y < obj2.y + obj2.height and 
           obj1.y + obj1.height > obj2.y
end

-- Function to resolve collision
function PhysicsEngine:resolveCollision(obj1, obj2)
    -- Simplistic collision resolving logic (overlap removal)
    local resolveX = (obj1.x + obj1.width/2) - (obj2.x + obj2.width/2)
    local resolveY = (obj1.y + obj1.height/2) - (obj2.y + obj2.height/2)

    if math.abs(resolveX) > math.abs(resolveY) then
        if resolveX > 0 then
            obj1.x = obj1.x + obj2.width
        else
            obj1.x = obj1.x - obj1.width
        end
    else
        if resolveY > 0 then
            obj1.y = obj1.y + obj2.height
        else
            obj1.y = obj1.y - obj1.height
        end
    end
end

-- Function to update object positions
function PhysicsEngine:update(dt)
    for _, object in ipairs(self.objects) do
        -- Apply gravity to the object
        object.y = object.y + self.gravity.y * dt
        -- Handle boundaries
        object.y = math.max(0, math.min(object.y, love.graphics.getHeight() - object.height))
    end
    self:collisionDetection()
end

return PhysicsEngine
