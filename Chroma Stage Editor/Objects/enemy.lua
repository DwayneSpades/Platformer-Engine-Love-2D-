Enemy_1 = Object:extend()

function Enemy_1:new()
enemy={}
spawner={}
playerx=0
playery=0


for x,row in pairs(grid) do
  for y,collumb in ipairs(row)do
    if grid[x][y]==10 then
      spawn=create_enemy_spawner((x-1)*32,(y-1)*32)
    table.insert(enemy,spawn)
    end
  end
end
end
function Enemy_1:update(dt)
 

 
  for i,bot in ipairs(enemy) do
    local oldx=round(bot.x,0)
    local oldy=round(bot.y,0)
    
    
    
    local locx=math.floor((bot.x+(bot.w/2))/cellsize)+1
  
    local locy=math.floor((bot.y+(bot.h/2))/cellsize)+1
    local resist=nil

  
     for c,h in ipairs(bullets) do
       if sphere_rec(h.x,h.y,h.r,bot.x,bot.y,bot.w,bot.h) then
        table.remove(enemy,i)
        table.remove(bullets,c)
      end
  end
   
  
  
  
  bot.x=round(bot.x+(bot.speed*bot.dx)*dt,0)
  
  
  for i,v in ipairs(cols) do
    if CheckCollision(bot.x, bot.y, bot.w, bot.h, v.x, v.y,cellsize, cellsize) and (v.tile==1 or v.tile==2 or v.tile==9) then
       bot.dx=bot.dx*-1  
      bot.speed=50
      bot.x=oldx
      
      break
    else
      bot.speed=100
    end
  end
  if grid[locx][locy]==5 then
  local bonus=200
  
    bot.velocity=bot.jumpheight-bonus-50
    
    
end
   if grid[locx][locy]==3 then
    bot.gravity=400
    resist=true
  else
    resist=false
    bot.gravity=800
  end
  
  
  bot.y=round(bot.y+bot.velocity*dt,0)
  bot.velocity=bot.velocity+bot.gravity*dt
  
  if resist==true and bot.velocity>=200 then
    bot.velocity=200
  elseif bot.velocity>=500 and resist== false then
    bot.velocity=500
  end
  
  
  
  for i,v in ipairs(cols) do
    if CheckCollision(bot.x, bot.y, bot.w, bot.h, v.x, v.y,cellsize, cellsize) and (v.tile==1 or v.tile==2 or v.tile==9) then
         
      bot.velocity=50
      bot.y=oldy
      
      break
    else
      
    end
  end
  
   
  end
 

  
  end
 



function Enemy_1:draw()

  for i, enemy in ipairs(enemy) do
      love.graphics.setColor(1,1,1)
  if get_dist(playerx,playery,enemy.x,enemy.y)<925 then
  love.graphics.draw(enemy.sprite, enemy.x,enemy.y)
  end
  end
end

function create_enemy_spawner(x,y)
  e_stats={ 
  x=x,
  y=y,
  w=28,
  h=28,
  speed=100,
  dx=1,
  velocity=0,
  gravity=800,
  jumpheight=-400,
  sprite=love.graphics.newImage('enemy.png')

  } 
 
 return e_stats
end

function create_enemy()
  e_stats={ 
  x=(selectedX-1)*32,
  y=(selectedY-1)*32,
  w=28,
  h=28,
  speed=100,
  dx=1,
  velocity=0,
  gravity=800,
  jumpheight=-400,
  sprite=love.graphics.newImage('enemy.png')
  } 
 
 return e_stats
end