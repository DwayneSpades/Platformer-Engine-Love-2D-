
Active_obj = Object:extend()
local dx=0
function Active_obj:new(x,y,w,h,speed)
  
  self.w=w
  self.h=h
  self.x=x
  self.y=y
  fade=false
  blick_b=0
  next_room=false
  playerx=self.x
  playery=self.y
  p_velocity=0
  x_vel=speed
  self.s=0
  s=speed
  spike=false
  selectedX=0
  selectedY=0
  if selectedX>gx then
    selectedX=gx
  end
  if selectedY>gy then
    selectedY=gy
  end
  playerX=0
  playerY=0
  playerdx=1
  spring=false
  isColliding=false
  isColliding=false
  moving=false
  memspeed=0
  memtrig=false
  resist=false
  held=false
  coin=false
  go_through=false
  boostr=false
  boostl=false
  boost_time=60
  boost_max=60
  face=1
  paint=false
  gate=423
end
released=false
function Active_obj:update(dt)
  
 
  selectedX = (math.floor((love.mouse.getX() / cellsize)+(camera._x/cellsize)))+1
  selectedY = (math.floor((love.mouse.getY() / cellsize)+(camera._y/cellsize)))+1
  
   
   local dy=0
  playerx=self.x
  playery=self.y
  
 
  if moving ==false then
  if love.keyboard.isDown('left') and boost_time==boost_max or boostl then 
   
    moving=true
    if isCollidingx then
    self.s=50
  elseif memtrig==true then
    self.s=memspeed
    memtrig=false
    
    else
    self.s=self.s+95
  end
  
    dx= -1
    playerdx=dx
    face=-1
  
  end
  if love.keyboard.isDown('right') and boost_time==boost_max  or boostr   then
    
    moving=true
    if isCollidingx then
    self.s=50
     elseif memtrig==true then
    self.s=memspeed
    memtrig=false
    else
    self.s=self.s+95
  end
  
    dx= 1
    playerdx=dx
    face=1
  end
else
  moving=false
end

 
  if love.keyboard.isDown('space') then
    held=true
  end
  
  boost_time=boost_time+1
  x_vel=x_vel-1
  
  if x_vel<=s then
    x_vel=s
  end
  
  if boost_time>=boost_max then
    boost_time=boost_max
    boostl=false
    boostr=false
    x_vel=s
  end
  
    if face==1 and boost_time<boost_max and boostl==false then
      boostr=true
      self.s=900
    end
    
    if face==-1 and boost_time<boost_max and boostr==false then
      boostl=true
      self.s=900
    end
    
  
  
  playerX=math.floor((self.x+(16))/cellsize)+1
  playerY=math.floor((self.y+(16))/cellsize)+1
 

  if grid[playerX][playerY]==4 then
    temp=false
    Gotoroom('Title')
  elseif grid[playerX][playerY]==11 then
      rememberx=self.x
      remembery=self.y
      remembered=true
  elseif grid[playerX][playerY]==7 then
      boost_time=0
  elseif grid[playerX][playerY]==8 then
      temp=false
      Gotoroom('finish')
  elseif grid[playerX][playerY]==12 then
    fade=true
    next_room=true
   end
   
  
  
  if blick_b==0 and fade==true then
   if blick  <1 then
      blick = blick +0.1
     
   end
end

 blick_b=blick_b+1
 
 if blick_b>=3 then
    blick_b=0
 end
 
  if grid[playerX+face][playerY]==9 and points<gate then
      paint=true
  else
    paint=false
  end
  
  
  local oldx=round(player.x)
  local num=150*dt
  local step=math.floor(self.s/num)
  
 
  if self.s>=300 and (boostl==false and boostr==false) then
    self.s=300
  end
  
  self.x=self.x+(self.s*dx)*dt
  
  
  if isCollidingx then
  self.s=50  
end

  if moving==false then
  self.s=self.s-1800*dt
  end
  
 
  
  
  if self.s<=0 and moving==false then
    self.s=0
    dx=0
    memtrig=false
  end
  
  
  for k, v in ipairs(enemy) do
  
if CheckCollision(self.x, self.y, self.w, self.h, v.x, v.y,v.w, v.h)  then
  temp=false
  Gotoroom('Title')
end
end
if coin==true then
  coin=false
  
  points=points+1
end

for k, v in ipairs(cols) do


if CheckCollision(self.x, self.y, self.w, self.h, v.x, v.y,cellsize, cellsize) and (v.tile==6 or v.tile==9 and points>=door_max)  then
  local cox=math.floor((v.x+(16))/cellsize)+1
  local coy=math.floor((v.y+(16))/cellsize)+1
  
  
    if v.tile~=9 then
    if grid[cox+1][coy]==3 or grid[cox+1][coy+1]==3 or grid[cox][coy+1]==3 or grid[cox-1][coy]==3 or grid[cox][coy-1]==3 or grid[cox-1][coy-1]==3 or grid[cox+1][coy-1]==3 or grid[cox-1][coy+1]==3 then
        grid[cox][coy]=3
        v.tile=3
        coin=true
      
    
    
 elseif grid[cox+1][coy]==5 or grid[cox+1][coy+1]==5 or grid[cox][coy+1]==5 or grid[cox-1][coy]==5 or grid[cox][coy-1]==5 or grid[cox-1][coy-1]==5 or grid[cox+1][coy-1]==5 or grid[cox-1][coy+1]==5 then
        grid[cox][coy]=5
        v.tile=5
        coin=true
      else
      grid[cox][coy]=0
      v.tile=0
      coin=true
    end
  elseif v.tile==9 then
    if grid[cox+1][coy]==3 or grid[cox+1][coy+1]==3 or grid[cox][coy+1]==3 or grid[cox-1][coy]==3 or grid[cox][coy-1]==3 or grid[cox-1][coy-1]==3 or grid[cox+1][coy-1]==3 or grid[cox-1][coy+1]==3 then
        grid[cox][coy]=3
        v.tile=3
        
      
    
    
 elseif grid[cox+1][coy]==5 or grid[cox+1][coy+1]==5 or grid[cox][coy+1]==5 or grid[cox-1][coy]==5 or grid[cox][coy-1]==5 or grid[cox-1][coy-1]==5 or grid[cox+1][coy-1]==5 or grid[cox-1][coy+1]==5 then
        grid[cox][coy]=5
        v.tile=5
    
      else
      grid[cox][coy]=0
      v.tile=0
  
    end
  end
  end
end

  
--Checks for collisions on the x axis
for k, v in ipairs(cols) do
  
if CheckCollision(self.x, self.y, self.w, self.h, v.x, v.y,cellsize, cellsize) and (v.tile==1 or v.tile==2 or v.tile==9) then
      isCollidingx = true      
      if memtrig==false then
      memspeed=self.s
      memtrig=true
      end
      break
    else
      isCollidingx = false
    end
  end
  
--dampens the player speed when near walls to get accurate collisions
  if isCollidingx  then
   
  --self.x=playerX
  self.x=round(oldx,0)
  
  onGround=true
-- if there is collision take player back to last known x position
 else
   
end 

if grid[playerX][playerY]==5 then
  local bonus=200
  spike=false
  if held==true then
    bonus=400
  end
  
    p_velocity=jumpheight-bonus
    spring=true
    onGround=false
end


--Y CONTROLS---------------------------------------------------------------------------------------------------------
local oldy=player.y

 --jump and gravity information
   
   jumpheight=-350
   if grid[playerX][playerY]==3 then
    p_gravity=400
    resist=true
  else
    resist=false
    p_gravity=800
  end
  
   
 --will probably use jumpcount later to do double jumps or triple jump abilities
 --jumpcount=0
   local num=150*dt
   local fall=math.floor(self.s/num)
 --moves player across y axis and acts as gravity 
  self.y=self.y+p_velocity*dt
  p_velocity=p_velocity+p_gravity*dt
  if spike then
     local bonus=2800
    p_velocity=p_velocity+bonus
  end
  
  --Don't fix whats not broke...
  --[[for i=0,num, 1 do
    self.y=self.y+(fall)*dt
  end]]
  if resist==true and p_velocity>=200 and spike==false then
    p_velocity=200
  elseif p_velocity>=500 and resist== false and spike==false then
    p_velocity=500
   elseif p_velocity>=900 and spike==true and (grid[playerX][playerY]~=6 or grid[playerX][playerY+1]~=6) then
    p_velocity=900
  end
  
  
   if grid[playerX][playerY-1]==2  then
      go_through=true
      
  elseif (grid[playerX][playerY]~=2 and isCollidingx==false) then  
    go_through=false
  end
  
  --player.y=round(player.y,5)
 
  
--second loop to check collision on y axis
for k, v in ipairs(cols) do
if CheckCollision(self.x, self.y, self.w, self.h, v.x, v.y, cellsize, cellsize) and go_through==false and (v.tile==1 or v.tile==2 or v.tile==9) then
  
  
--checks if player is on the ground or not also resets the dash mechanic
  if self.y < v.y then
    onGround=true
    spring=false
    released=false
    spike=false
  else
    onGround=false
  end
  

 -- if self.y > v.y then
 
  --end
  
  --initial statement that the y axis has a collision
  isColliding = true
      break
    else
  isColliding = false
end
end

--if there is collision take the player back to last y known position
if isColliding  then

p_velocity=50

--print('playerY: '..playerY)]]
self.y=round(oldy,0)
local playerY=math.floor((self.y+(28))/cellsize)+1

if grid[playerX][playerY]==4 then
    Gotoroom('Title')
  end
--print('self.y: '..self.y)

end 

--  makes camera follow player
  camera:setBounds(0, 0, stage_width,stage_height)
  camera:setPosition( round(self.x-love.graphics.getWidth()/2), round(self.y-(love.graphics.getHeight()/2))) 
  


end



function Active_obj:draw()
  
  love.graphics.setColor(1,1,1,1)
  
  local char =love.graphics.newImage('player.png')
  local player=love.graphics.draw(char,self.x,self.y)
  
  if paint==true then
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle('fill',self.x-20,self.y-20,200,32)
    love.graphics.setColor(0,0,0)
    love.graphics.print('You need at least '..door_max..' coins',self.x-20,self.y-20)
  end
 

end

