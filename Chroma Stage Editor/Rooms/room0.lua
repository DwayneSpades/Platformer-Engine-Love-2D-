
Room_0=Object:extend()

baka=false
local name='Room_0'
function unrequire(m)
    package.loaded[m] = nil
    _G[m] = nil
end

function Room_0:new()
  map_count={}
  recursiveEnumerate('loaded_level', map_count)
  --number of maps
  num_maps=#map_count
 
  --autoload maps
  for i=0,#map_count do
    if i==sel_num then
      require ((map_count[i]:sub(1,-5)))
    end
  end
  
  --loads the currently selected map
   loaded_map=tile_map
   
  --[[local map_files = {}
  recursiveEnumerate('maps', map_files)
  requireFiles(map_files)]]
  
  --Automates class Files------------------------------------
  local object_files = {}
  recursiveEnumerate('Objects', object_files)
  requireFiles(object_files)
  
  --Objects------------------------------------------------------
  P_w=28
  P_h=28
  
  
  block_type=1
  
 
  map_width=lw
  map_height=lh
  
  stagewidth=map_width
  stageheight=map_height
  grid1=Grid(32,map_width,map_height,loaded_map)
  circ=Rot()
  
  if temp then
    player=Active_obj(playerx,playery,P_w,P_h,300)
  elseif debug_active==true and remembered==true then
      player=debug(rememberx,remembery,P_w,P_h,600)
     Enemy=Enemy_1()
     Bullet=Bullets()
  elseif remembered==true and debug_active==false then
     player=Active_obj(rememberx,remembery,P_w,P_h,300)
       Enemy=Enemy_1()
       Bullet=Bullets()
  elseif debug_active then
    player=debug(64,64,P_w,P_h,600)
     Enemy=Enemy_1()
     Bullet=Bullets()
  else
  player=Active_obj(64,64,P_w,P_h,300)
  Enemy=Enemy_1()
  Bullet=Bullets()
end
  
  
  love.window.setTitle('Chroma Stage Editor')

  
end

function Room_0:update(dt)

if baka==false then
  grid1:update(dt)
  player:update(dt)
  Bullet:update(dt)
  Enemy:update(dt)
  circ:update(dt)
elseif baka==true then
  write('your_map.lua')
end
  
if love.keyboard.isDown('q')  then
    temp=true
  Gotoroom('Menus')  
 collectgarbage()
end
end

function Room_0:draw(dt)

  love.graphics.setBackgroundColor(0.02,0.09,0.10)
 
  camera:draw(dt)
  
   if baka==false and (points>=point_max or debug_active)  then
     
  
  love.graphics.setColor(1,1,1,0.7)
  love.graphics.rectangle('fill',0,0,900,165)
  love.graphics.setColor(0,0,0)
  love.graphics.print('~Welcome to the Chroma Stage Editor~',10,0)
  love.graphics.print('Controls: LEFT and RIGHT arrow keys, SPACE to jump,\naim mouse and left click to place blocks, press E to switch to delete blocks mode,\nZ and X switches to the next block type to place.\nL spawns a special enemy type where the mouse cursor is.\nD is to shoot your new GUN Moduel.\nNo clip mode aka DEBUG MODE is in the options menu.\n\'W\' Deletes clears all blocks from the room.\n Press A or Q to go to the pause screen which has some tools. press E\nWARNING: DO NOT PLACE BLOCK ON PLAYER',10,30,0,1.02)
else
  love.graphics.setColor(0.2,0.2,0.4,0.5)
  love.graphics.rectangle('fill',10,0,800,115)
  love.graphics.setColor(0.8,0.6,0.2)
 
  love.graphics.print('~'..name..'~',10,0)
  love.graphics.print('Controls: LEFT and RIGHT arrow keys, SPACE to jump,\nPress Q to pause the game or change settings\nPress ESCAPE \'Esc\' to exit the program.',10,30)
  end
  love.graphics.setColor(0.2,0.2,0.4,0.5)
  love.graphics.rectangle('fill',0,love.graphics.getHeight()-60,240,64)
  love.graphics.setColor(0.0,1.0,0.0)
  love.graphics.print('Coins:'..points..'/'..point_max,0,love.graphics.getHeight()-60)
  love.graphics.setColor(0.9,0.2,1.0)
  if   ( points>=point_max or debug_active) then
    if selectedX <=gx and selectedY <=gy and mode==0 and block_type~=nil then
    local selx,sely=selectedX,selectedY
    love.graphics.print('Mouse x: '..selx..', Mouse y: '..sely..', Mode: Add Block, Current block type: '..get_block()..', Create block type:'..block_type..'level: '..sel_num,10,12)
    end
  elseif mode==1 and points>=point_max and selectedX <= self.gx and selectedY <=self.gy then
    love.graphics.print('Mouse x: '..selectedX..', Mouse y: '..selectedY..', Mode: Delete Block, Block type:'..block_type,10,12)
  end
  
if baka==true and points>=point_max then
  love.graphics.setColor(1,0,0)
  for x=1,100 do
    for y=1,100 do
      love.graphics.print('BAKA',(x-1)*(cellsize+10),(y-1)*cellsize)
    end
  end
  

  end
end