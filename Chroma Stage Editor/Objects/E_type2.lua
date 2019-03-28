
function create_enemy_2()
  local x=(selectedX-1)*32
  local y=(selectedY-1)*32
  e_stats_2={ 
  x=(selectedX-1)*32,
  y=(selectedY-1)*32,
  w=64,
  h=64,
  speed=50,
  dx=1,
  velocity=0,
  gravity=800,
  jumpheight=-400,
  sprite=love.graphics.newImage('big.png')
  } 
 
 return e_stats_2
end