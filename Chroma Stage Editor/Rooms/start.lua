
Start=Menus:extend()
local cellsizex=200
local cellsizey=32

function Start:new()
  
   menu_position=1
   menu_sizex=1
   menu_sizey=10
   map_list=num_maps
  
end

function Start:update(dt)
  
  if menu_position==1 and entered==true then
    backout=true
  
  end
  if menu_position==2 and entered==true then
    building_map=true
    
  end
  
  if menu_position==3 and entered==true and map_list>1 and sel_num~=1 then
    love.filesystem.remove(map_count[sel_num])
    sel_num=sel_num-1
    Gotoroom('Room_0')
    Gotoroom('Start')
  end
  
  
  if (menu_position==4 and entered==true) then
    unrequire(('loaded_level/map_'..sel_num))
    
    grid1=nil
    player=nil
    temp=false
    collectgarbage()
    next_room=false
    Gotoroom('Room_0')
  end
  
  if menu_position==5 and entered==true then
    Gotoroom('Title')
  end
  
   if menu_position==6 and entered==true then
    write(love.filesystem.getSaveDirectory()..'/saved_maps/level.lua')
    write('maps/level.lua')
    load_map(sel_num)
    
    
  end
  
  if menu_position==7 and entered==true then
    debug_active=true
    unrequire(('loaded_level/map_'..sel_num))
    grid1=nil
    player=nil
    temp=false
    collectgarbage()
    Gotoroom('Room_0')
  end
  
  if menu_position==8 and entered==true then
    write('saved_maps/custom_level.lua')
    no_file=false
  end
  
  if menu_position==9 and entered==true then
    load_custom_map(sel_num)
  end
  
  if menu_position==10 and entered==true then
    love.event.push('quit')
  end
  entered=false
end

function Start:draw()
  if map_list==1 then
    love.graphics.print('The Program requires at least one Tile_map to be present',300,300)
  end
  if no_file then
    love.graphics.print('NO MAP TO LOAD\nYOU MUST HAVE A FOLDER IN THE MAIN FOLDER CALLED: maps\nIN \"maps\" YOU MUST HAVE ONE FILE NAMED \"custom_level.lua\" \nWHICH MUST COME FROM AN EXPORTED MAP FROM THIS EDITOR.',love.graphics.getWidth()/2,love.graphics.getHeight()/2)
  end
  love.graphics.print('Controls:\nC and V to toggle which map to load\nPress Enter to pick an option\nUp and down arrows to traverse menus',300,350)
  for x=1,menu_sizex do
    for y=1,menu_sizey do
      
      if menu_position==y then
        love.graphics.setColor(0,0.3,1.0)
      else
        love.graphics.setColor(0.5,0.5,0.5)
      end
      love.graphics.rectangle('fill',(x-1)*cellsizex,(y-1)*(cellsizey+12),cellsizex,cellsizey)
      if y==1 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Back',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==2 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Add Tilemap',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==3 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Delete Tile_Map: '..map_count[sel_num],(x-1)*cellsizex,(y-1)*(cellsizey+12))
     elseif y==4 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Tile_map: '..map_count[sel_num],(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==5 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Title',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==6 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Save Tilemap',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==7 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Debug Mode',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==8 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Export Custom Map',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==9 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Load Custom Map',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==10 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Quit',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      end
    end
  end
end