
Title=Menus:extend()
local cellsizex=400
local cellsizey=100
local offsetX=(love.graphics.getWidth()/2)-200
local offsetY=(love.graphics.getHeight()/2)+100
function Title:new()
   menu_position=1
   menu_sizex=1
   menu_sizey=2
   title_art=love.graphics.newImage('Chroma struct.png')
end

function Title:update(dt)
  
  if menu_position==1 and entered==true then
    
    Gotoroom('Room_0')
  end
  if menu_position==2 and entered==true then
    love.event.push('quit')
  end
  entered=false
end

function Title:draw()
  love.graphics.setBackgroundColor(0.09,0.09,0.09)
  love.graphics.draw(title_art,(love.graphics.getWidth()/2)-300,(love.graphics.getHeight()/2)-500)
  love.graphics.print('Controls:\nPress Enter to pick an option\nUp and down arrows to traverse menus',love.graphics.getWidth()-300,love.graphics.getHeight()-300)
  for x=1,menu_sizex do
    for y=1,menu_sizey do
      love.graphics.setDefaultFilter('nearest','nearest')
      
      if menu_position==y then
        love.graphics.setColor(0,0.3,1.0)
      else
        love.graphics.setColor(0.5,0.5,0.5)
      end
      love.graphics.rectangle('fill',offsetX+((x-1)*cellsizex),offsetY+((y-1)*(cellsizey+12)),cellsizex,cellsizey)
      if y==1 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Start Game',offsetX+((x-1)*cellsizex),offsetY+((y-1)*(cellsizey+12)),0,4,4)
      elseif y==2 then
        love.graphics.setColor(1,1,1)
        love.graphics.print('Quit',offsetX+((x-1)*cellsizex),offsetY+((y-1)*(cellsizey+12)))
      end
    end
  end
end