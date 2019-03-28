
finish=Menus:extend()
local cellsizex=600
local cellsizey=200
local offsetX=300
local offsetY=200
function finish:new()
   menu_position=1
   menu_sizex=1
   menu_sizey=1
   
end

function finish:update(dt)
  if menu_position==1 and entered==true then
    Gotoroom('Title')
  end
 
  entered=false
end

function finish:draw()
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
        love.graphics.print('You Win !!!',offsetX+((x-1)*cellsizex),offsetY+((y-1)*(cellsizey+12)),0,4,4)
      end
    end
  end
end