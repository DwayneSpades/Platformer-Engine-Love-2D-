L_switch = Object:extend()


function L_switch:new()

  
end

function L_switch:update(dt)
 unrequire(('loaded_level/map_'..sel_num))
    if next_room then
    sel_num=sel_num+1
   end
    grid1=nil
    player=nil
    temp=false
    collectgarbage()
    next_room=false
    Gotoroom('Room_0')

end

function L_switch:draw()

end