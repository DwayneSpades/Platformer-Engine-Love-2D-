function love.keypressed(key)
  if key== 'p' then
     
    table.insert(shots, create_fire(1))
 end
 if (key=='right' and custom_msx<=10000 and x_mapchange) or (key=='right' and custom_msy<=10000 and y_mapchange) then
   if x_mapchange then
   custom_msx=custom_msx+10
 elseif y_mapchange then
   custom_msy=custom_msy+10
   end
 end
 if (key=='left' and custom_msx>=20 and x_mapchange) or (key=='left' and custom_msy>=20 and y_mapchange) then
   if x_mapchange then
   custom_msx=custom_msx-10
 elseif y_mapchange then
   custom_msy=custom_msy-10
   end
 end
 
  if key== 'l' then
    local spawn=create_enemy_2()
    table.insert(enemy,spawn)
  end
  if key== 'd' and (points>=point_max  or debug_active )then
    local shoot=gun()
    table.insert(bullets,shoot)
   
  end
  --Toggles block place and erase---------
  if key == 'e'and mode==0 and (points>=point_max or debug_active  )then
    mode=1
  elseif key == 'e' and mode==1 and (points>=point_max or debug_active  )then
    mode=0
  end
  --Toggle blocks-------------------------------
  if key =='z' and block_type>0 and (points>=point_max or debug_active  )then
    block_type=block_type-1
  end
  if key =='x' and block_type<12 and (points>=point_max or debug_active  )then
    block_type=block_type+1
  end
  if key =='c' and sel_num>1 and (points>=point_max or debug_active  )then
    sel_num=sel_num-1
  end
  if key =='v' and sel_num<num_maps and (points>=point_max or debug_active  )then
    sel_num=sel_num+1
  end
  --Menu Controls-----------------------
   if key=='up'  then
    
     menu_position=menu_position-1
    if menu_position<=0 then
      menu_position=menu_sizey
    end
  end
  
  if key=='down' then
    spike=true
    menu_position=menu_position+1
    if menu_position>=menu_sizey+1 then
      menu_position=1
    end
  
  end
  --Menu Presss Confirmation---------------------
  entered=false
  if key == 'return' then
      entered=true
  end
  
  --jump button------------------------------
  if key == 'space'and onGround==true and spike==false then
    p_velocity=jumpheight
    onGround=false
    held=true
  end
  --Clears all placed blocks except level bounds----
  if key == 'w' and (points>=point_max  or debug_active) then
    local nextgrid={}
    for x=1, lw do
    nextgrid[x]={}
      for y=1, lh do
        nextgrid[x][y]=0
      end
    end
    local nextcols={}
    for x,rows in ipairs(nextgrid) do
      
      for y,collumb in ipairs(rows) do
        nextgrid[x][y]= 0
        nextgrid[lw][y]=1
        nextgrid[x][lh]=1
        nextgrid[1][y]=1
      end
    end
    grid = nextgrid
    cols = nextcols
    create_collision(nextgrid)
  end
  
end

function love.keyreleased(key)
--[[if key=='d' then
  boost_time=boost_max
end]]
if  key== 'space' then
  held=false
end
--when jump key is released it stops the upward movement
if key== 'space' and spring==false and released==false and p_velocity<0 then
  if p_velocity==p_velocity then
    p_velocity=p_velocity/2
    released=true
  end
end

--quit button closes the game
  if key=='escape' then
  love.event.quit()
  end
end

function get_coins()
  local coins=0
    for i,v in ipairs(cols) do
      if v.tile==6 then
        coins=coins+1
      end
      
    end
    return coins
end

function get_dist(x1,y1,x2,y2)
  local distance=math.sqrt(((x1-x2)^2)+((y1-y2)^2))
  return distance
end
