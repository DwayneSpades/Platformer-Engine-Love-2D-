require 'Objects/misc'
Map_builder=Object:extend()
local cellsizex=98
local cellsizey=32

function Map_builder:new()

   menu_position=1
   menu_sizex=1
   menu_sizey=4
   custom_msx=10
   custom_msy=10
   x_mapchange=false
   y_mapchange=false
end

function Map_builder:update(dt)

  if menu_position==1 and entered==true  then
    options=true
   
  end
  if menu_position==2  then
     x_mapchange=true
  else
   x_mapchange=false
  end
  if menu_position==3   then
   y_mapchange=true
 else
   y_mapchange=false
  end
  if menu_position==4 and entered==true then
    
    lw=custom_msx
    lh=custom_msy
    
    write(love.filesystem.getSaveDirectory()..'/saved_maps/level.lua')
    load_map(sel_num+1)
    love.filesystem.newFile('loaded_level/map_'..(sel_num+1)..'.lua')
    Gotoroom('Room_0')
   
  end
  entered=false
end

function Map_builder:draw()
  love.graphics.print('Controls:\nPress Enter to pick an option\nUp and down arrows to traverse menus\nright arrow to increase map size and left aroow to decrease map size',love.graphics.getWidth()-300,love.graphics.getHeight()-300)
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
        love.graphics.setColor(1,0,0)
        love.graphics.print('Map Sizex: '..custom_msx,(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==3 then
        love.graphics.setColor(1,0,0)
        love.graphics.print('Map Sizey: '..custom_msy,(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==4 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Add Map to Directory',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      end
    end
  end
end