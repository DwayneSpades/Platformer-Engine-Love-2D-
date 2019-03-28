require 'Objects/misc'
Menus=Object:extend()
local cellsizex=98
local cellsizey=32

function Menus:new()

   menu_position=1
   menu_sizex=1
   menu_sizey=4
   
end

function Menus:update(dt)

  if menu_position==1 and entered==true  then
    pause=true
   
  end
  if menu_position==2 and entered==true and debug_active   then
    options=true
    
  end
  if menu_position==3 and entered==true  then
    Gotoroom('room1')
    
    
  end
  if menu_position==4 and entered==true then
    love.event.push('quit')
  end
  entered=false
end

function Menus:draw()
  love.graphics.print('Controls:\nPress Enter to pick an option\nUp and down arrows to traverse menus',love.graphics.getWidth()-300,love.graphics.getHeight()-300)
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
        love.graphics.print('Resume',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==2   then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Tools',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==3 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Options',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==4 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Quit',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      end
    end
  end
end