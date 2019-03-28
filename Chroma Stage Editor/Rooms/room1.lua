
room1=Menus:extend()
local cellsizex=200
local cellsizey=32

function room1:new()
  
   menu_position=1
   menu_sizex=1
   menu_sizey=3
  
  
end

function room1:update(dt)
  
  if menu_position==1 and entered==true then
    backout=true
  
  end
  
  if menu_position==2 and entered==true  then
    
    if full_trig==false then
    love.window.setFullscreen(true)
    full_trig=true
  else 
    love.window.setFullscreen(false)
    full_trig=false
    end
    
  end
  
  if menu_position==3 and entered==true then
    love.event.push('quit')
  end
  entered=false
end

function room1:draw()
 
  love.graphics.print('Controls:\nPress Enter to pick an option\nUp and down arrows to traverse menus',300,350)
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
        love.graphics.print('Toggle Fullscreen/Windowed',(x-1)*cellsizex,(y-1)*(cellsizey+12))
      elseif y==3 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Quit '..map_count[sel_num],(x-1)*cellsizex,(y-1)*(cellsizey+12))
     
      end
    end
  end
end