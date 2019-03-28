function love.conf(t)
  t.console = false
  t.window.width=1280
  t.window.height=920
  t.identity = 'Chromastruct'  
  
   
end

function toggle(t)
if t.window.fullscreen==true then
  t.window.fullscreen=false
  
else
  t.window.fullscreen=true
  end
end

