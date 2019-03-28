require 'gameloop'
require 'libraries/camera'

Object = require 'libraries/classic'
baka=false
debug_active=true

full_screen=true
--level_to_load=true
function love.load()
  
 local map_files = {}
  recursiveEnumerate('saved_maps', map_files)
  requireFiles(map_files)
  
  local rooms = {}
  recursiveEnumerate('Rooms', rooms)
  requireFiles(rooms)
  
  if((love.filesystem.getInfo("loaded_level")==nil) or (love.filesystem.getInfo("saved_maps"))==nil) then
    love.filesystem.createDirectory("loaded_level")
    love.filesystem.createDirectory("saved_maps")
    load_custom_map()
    load_map(1)
    print('OKAY')
  else
     
  end
 
  --lw,lh=nil
  loaded_map=tile_map
  
  
  
  --[[  file=love.filesystem.newFile('loaded_level/mape_1.lua','w')
    file:write('A map hello')
    file:close()
    print(data)]]
  
  full_trig=false
  Win=0
  points=0
  point_max=224
  door_max=223
  
  blick=0
  pause=false
  options=false
  backout=false
  building_map=false
  map_to_build=false
  temp=false
  remembered=false
  no_file=false
  current_room = nil
  custom_msx=10
  custom_msy=10
  sel_num=1
  Gotoroom('Room_0')
  load_level()
  Gotoroom('Title')
   Logo=love.image.newImageData('Chroma_logo.png',600,600)
  
  love.window.setIcon(Logo)
end

function love.update(dt)

love.timer.sleep(0.05*dt)
  if pause==true then
    Gotoroom('Room_0')
  elseif options== true then
    Gotoroom('Start')
  elseif backout== true then
    Gotoroom('Menus')
  elseif building_map then
    map_to_build=true
    Gotoroom('Map_builder')
    
  end
  pause=false
  options=false
  backout=false
   building_map=false
  if selectedX>gx then
    selectedX=gx
  end
  if selectedY>gy then
    selectedY=gy
  end
if current_room then current_room:update(dt)end


end

function love.draw()
  
  if current_room then current_room:draw()end
  love.graphics.print('FPS: '..love.timer.getFPS(),300,0)
end

function Gotoroom(room,...)
  
  current_room= _G[room](...)
  
  
end
--Takes the path and requires them--------------------------------------
function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.getInfo(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function read(filename)
  local fh = assert(io.open(filename,"r+"))
end

function write(filename)
  if baka==false then

  fh = assert(io.output(filename, "w"))
  end
  if baka==true then
  fh = assert(io.output(filename, "w"))
  end
  local line=1
  local let=1
  local start_line=true
  local begin=false
  local end_line=false
  local before_end=false
  fh:write('lw,lh='..stagewidth..','..stageheight..'\n')
  fh:write('tile_map={\n')
  for x=1, stagewidth do
    fh:write('{')
    for y=1, stageheight do
    
    fh:write(grid[x][y]..',')
    let=let+1
  end
   
  if (line==stagewidth)then
    fh:write('}\n')
  else 
  fh:write('},\n')
  line=line+1
  let=1
  end
end
  fh:write('}\n')
  fh:flush()
  fh:close()
end

function load_map(i)
local data=love.filesystem.read('saved_maps/level.lua')

level_loaded=love.filesystem.newFile('loaded_level/map_'..i..'.lua','w')
level_loaded:write(data)
level_loaded:flush()
level_loaded:close()

end

function load_custom_map()
  

local map=love.filesystem.read('maps/level.lua')

local location=love.filesystem.newFile('saved_maps/level.lua','w')
location:write(map)
location:flush()
location:close()


end

