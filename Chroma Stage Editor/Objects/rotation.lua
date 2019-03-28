Rot = Object:extend()
local speed=10
function Rot:new()
  speed=10
  Rx2, Ry2 =0,0
  R2y2,R2x2=0,0
  R3x,R3Y=0,0
  R4x,R4y=0,0
  shots={}
  spawn_b=0
end

function Rot:update(dt)
  local now = love.timer.getTime()
  local now2 = love.timer.getTime()-60
  local now3 = love.timer.getTime()-60
 
if spawn_b==0 then
  table.insert(shots, create_fire(1))
  table.insert(shots, create_fire(2))
end
 spawn_b=spawn_b+1
 if spawn_b>=3 then
    spawn_b=0
 end
 
  --[[if #shots<=1000 then
  table.insert(shots, create_fire(1))
  table.insert(shots, create_fire(2))
 end]]
	-- Clear fixture hit list.
	-- Ray.hitList = {}
for i,n in ipairs(shots) do
 
  
    --[[if #shots>=20 then 
      table.remove(shots,i)
    end]]
   
if n.emitter==1 then
    n.time= love.timer.getTime()+n.prog
    if n.turn==false then
      
    n.pos=((n.time-9.5)+1.5)*10

    
         n.turn=true
    end 
    n.prog=n.prog+0.1
    n.progx=n.progx+0.09
    n.progy=n.progy+0.05
    if playerdx==-1 then
       n.x=n.x+ ((math.sin(n.pos )* n.progx)-(1.5))*playerdx
    n.y=n.y+ (math.cos(n.pos ) * n.progy)-n.progy
    else
     n.x=n.x+ ((math.sin(n.pos )* n.progx)-(0.4))*playerdx
    n.y=n.y+ (math.cos(n.pos ) * n.progy)-n.progy
      end
    
    
    
    if n.life<=0 then
        table.remove(shots,i)
    end
    --n.speedy=n.speedy+0.5
   -- n.speedx=n.speedx+0.05
    n.life=n.life-1
end

if n.emitter==2 then
    n.time= love.timer.getTime()+n.prog
    if n.turn==false then
      
    n.pos=((n.time)-1.5)*10
     n.turn=true
    end
     
    n.prog=n.prog+0.1
    n.progx=n.progx+0.09
    n.progy=n.progy+0.05
    
   if playerdx==-1 then
       n.x=n.x+ ((math.sin(n.pos )* n.progx)-(1.5))*playerdx
    n.y=n.y+ (math.cos(n.pos ) * n.progy)-n.progy
    else
     n.x=n.x+ ((math.sin(n.pos )* n.progx)-(0.5))*playerdx
    n.y=n.y+ (math.cos(n.pos ) * n.progy)-n.progy
    end
    
    if n.life<=0 then
        table.remove(shots,i)
    end
    --n.speedy=n.speedy+0.5
   -- n.speedx=n.speedx+0.05
    n.life=n.life-1
end


for c,h in ipairs(cols) do
       if sphere_rec(n.x,n.y,n.r,h.x,h.y,32,32) and h.tile==1 then
        table.remove(shots,i)
        end
  end
  
end


  
	-- Calculate ray position.
--[[	local pos = ((now)*1)
  local po2 = ((now)*1)+3
  local po3 = ((now)*1)+1.5
  local po4 = ((now)*1)+4.6
  local pos2 = (math.sin(now2/30)*speed)+3
  
   pos3 = (math.sin(now3/30)*speed)
  local mousex=love.mouse.getX()
  local mousey=love.mouse.getY()
  --mouse cursor
	Rx2, Ry2 = (math.sin(pos )*15)+mousex+(camera._x) , (math.cos(pos ) * 15)+mousey+(camera._y)
  R2x2, R2y2 = (math.sin(po2 )*15)+mousex+(camera._x) , (math.cos(po2 ) * 15)+mousey+(camera._y)
   R3x, R3Y = (math.sin(po3 )*15)+mousex+(camera._x) , (math.cos(po3 ) * 15)+mousey+(camera._y)
   R4x, R4y = (math.sin(po4 )*15)+mousex+(camera._x) , (math.cos(po4 ) * 15)+mousey+(camera._y)
   
 Rcx2, Rcy2 =  (math.cos(pos2 ) * 25)+mousex, (math.sin(pos2 )*25)+mousey
  Rbx2, Rby2 = (math.cos(pos3 )*25)+mousex , (math.sin(pos3 ) * 25)+mousey
   Rax2, Ray2 = (math.sin(pos3 )*255)+mousex , (math.cos(pos3 ) * 255)+mousey]]
end

function Rot:draw()
  --[[love.graphics.circle('fill', Rx2,Ry2,3)
  love.graphics.circle('fill', R2x2,R2y2,3 )
  love.graphics.circle('fill', R3x,R3Y,3 )
  love.graphics.circle('fill', R4x,R4y,3 )
  ]]
  for i,n in ipairs(shots) do
    if get_dist(playerx,playery,n.x,n.y)<925 then
      love.graphics.draw(n.sprite, n.x,n.y,n.prog,n.prog,n.prog)
    end
end
end

function create_fire(e)
  fire={
    x= playerx+13,
    y= playery+13,
    r=6,
    speedx=1,
    speedy=1,
    life=20,
    spin=0,
    pos=0,
    time=0,
    prog=0,
    progx=0,
    progy=0,
    turn=false,
    emitter=e,
    sprite=love.graphics.newImage('bullet.png')
  }
  
  return fire
end