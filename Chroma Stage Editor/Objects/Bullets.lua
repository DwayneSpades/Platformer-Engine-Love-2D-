Bullets= Object:extend()

function Bullets:new()
  bullets={}
end

function Bullets:update(dt)
  for i,b in ipairs(bullets) do
    b.x=b.x + (b.speed*b.dx) * dt
    
    
    if b.decay<=0 then
      table.remove(bullets,i)
    end
    
    
    b.decay=b.decay-1
    
   for l,h in ipairs(cols) do
       if sphere_rec(b.x,b.y,b.r,h.x,h.y,32,32) and h.tile==1 then
        table.remove(bullets,i)
        end
  end 
  
  end
  
  
  
end

function Bullets:draw()
   for i,b in ipairs(bullets) do

    love.graphics.circle('fill',b.x,b.y,b.r)
    
  end
  
end

function gun()
  bullet={
    x=playerx+13,
    y=playery+13,
    r=5,
    speed=2*x_vel,
    decay=100,
    dx=playerdx
    }
  
  return bullet
end
