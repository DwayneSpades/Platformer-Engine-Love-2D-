


function load_level(dt)
  camera:newLayer(1, function(dt)
    
    grid1:draw()
    Bullet:draw()
     Enemy:draw()
    circ:draw()
    player:draw()
     love.graphics.setColor(0,0,0,blick)
 love.graphics.rectangle('fill',0,0,1000,1000)
    
  
  end)
end
