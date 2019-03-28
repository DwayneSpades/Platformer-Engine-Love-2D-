Grid = Object:extend()
mode=0

require 'Objects/misc'

function Grid:new(cell_s,sizeX,sizeY,maps) 
  --local maps = {}
  --sel_num=2
  --recursiveEnumerate('maps', maps)
  
  --selects a specific map-----------
 --[[ for i=1, #maps do
    if i==sel_num then
      local map=maps[i]
      map=map:sub(1,-5)
      require (map)
    end
  end
  local loadm=maps[2]]
  cellsize=cell_s
  self.gx=sizeX
  self.gy=sizeY
  
  gx=sizeX
  gy=sizeY
  gridX=1
  gridY=1
  grid={}
  gates={}
  for x=1, gx do
    grid[x]={}
    for y=1, gy do
    grid[x][y]=0
    stage_width=((x)*cellsize)-1280
    stage_height=((y)*cellsize)-620
    end
  end
  
  --display_w=20
  --display_h=20
 if map_to_build then
   create_collision(grid)
   map_to_build=false
  else 
  grid=maps
  create_collision(grid)
end

  -----------------------------------------------------------------
  top=1
  left=1
  --this happens to be the minimum drawsize for a map
  tilesDisplayWidth = 10
  tilesDisplayHeight = 10
  
  tilesetImage = love.graphics.newImage( "Untitled.png" )
  tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
  tileSize = 32
  tileQuads={}
  -- blue
  tileQuads[0] = love.graphics.newQuad(0 , 0, tileSize, tileSize,160,64)
  -- red
  tileQuads[1] = love.graphics.newQuad(0, 32, tileSize, tileSize,160,64)
  -- green
  tileQuads[2] = love.graphics.newQuad(32, 0 , tileSize, tileSize,160,64)
  -- yellow
  tileQuads[3] = love.graphics.newQuad(32, 32, tileSize, tileSize,160,64)
  --Death block
  tileQuads[4] = love.graphics.newQuad(64, 0, tileSize, tileSize,160,64)
  --Bounce block
  tileQuads[5] = love.graphics.newQuad(64, 32, tileSize, tileSize,160,64)
  --Coins
  tileQuads[6] = love.graphics.newQuad(96, 0, tileSize, tileSize,160,64)
  --boost pad
  tileQuads[7] = love.graphics.newQuad(96, 32, tileSize, tileSize,160,64)
  --Win Block
  tileQuads[8] = love.graphics.newQuad(128, 0, tileSize, tileSize,160,64)
  --Win Block
  tileQuads[9] = love.graphics.newQuad(128, 32, tileSize, tileSize,160,64)
  --spawner
  tileQuads[10] = love.graphics.newQuad(0, 0, tileSize, tileSize,160,64)
  --Checkpoint marker
  tileQuads[11] = love.graphics.newQuad(0, 0, tileSize, tileSize,160,64)
  --Door
  tileQuads[12] = love.graphics.newQuad(0, 0, tileSize, tileSize,160,64)
  
  tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)
  updateTilesetBatch(0,0)
  
  --[[This is how to change the type of tile: grid[1][1]=1
  grid[10][10]=1]]
  
  

  --love.keyboard.setKeyRepeat(false)
end

function updateTilesetBatch(top,left)
   limx=top
   limy=left
  if limx<0 then
    limx=0
  end
  if limy<0 then
    limy=0
  end
  tilesetBatch:clear()
  for x=limx, tilesDisplayWidth-1 do
    for y=limy, tilesDisplayHeight-1 do
      tilesetBatch:add(tileQuads[grid[x+gridX][y+gridY]], x*tileSize, y*tileSize)
    end
  end
  tilesetBatch:flush()
end

function Grid:update(dt)
 --[[ if love.keyboard.isDown('l') then
    local r=assert(io.open('maps/level.lua','r+'))
    r:write('YOOOOOO...')
    r:flush()
    r:close()
    create_collision(grid)
  end]]
    top=-30+(playerY)
    left=-50+(playerX)
    tilesDisplayWidth = playerX+50
    tilesDisplayHeight = playerY+30
    if tilesDisplayWidth>=gx then
      tilesDisplayWidth=gx
    end
    if tilesDisplayHeight>=gy then
        tilesDisplayHeight=gy
    end


  updateTilesetBatch(left,top)
  --[[for x,row in ipairs (grid) do
    for y,collumb in ipairs (row) do
      
    end
  end]]
  if points>=point_max or debug_active then
  if love.mouse.isDown(1) and mode==0  and selectedX <= self.gx and selectedY <=self.gy and selectedX==playerX and selectedY==playerY  and grid[selectedX][selectedY]==0  then
        baka=true
        
      elseif love.mouse.isDown(1) and mode==0  and selectedX <= self.gx and selectedY <=self.gy and selectedX==playerX and selectedY==playerY  and grid[selectedX][selectedY]==0 or (love.mouse.isDown(1) and selectedX==playerX+1 and selectedY==playerY) or (love.mouse.isDown(1) and selectedY==playerY+1 and selectedX==playerX) or (love.mouse.isDown(1) and selectedX==playerX-1 and selectedY==playerY) then
    
      
      
      elseif love.mouse.isDown(1) and mode==0  and selectedX <= self.gx and selectedY <=self.gy  then
        grid[selectedX][selectedY]=block_type
        if block_type==11 then
          table.insert(gates, {x=selectedX, y=selectedY, max=points})
        end
        table.insert(cols, {x=(selectedX-1)*32, y=(selectedY-1)*32,tile=block_type})
       
    
      elseif love.mouse.isDown(1) and mode==1 and selectedX <= self.gx and selectedY <=self.gy  then
        grid[selectedX][selectedY]=0
        create_collision(grid)
      end
  end
end



function Grid:draw()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(tilesetBatch)
  if points>=point_max or debug_active then
 

    if selectedX <= self.gx and selectedY <=self.gy then
    love.graphics.setColor(1,0,0,0.5)
    love.graphics.rectangle('fill',(32*(selectedX-1)),(32*(selectedY-1)),cellsize,cellsize)
    local selectedX = (math.floor((love.mouse.getX() / cellsize)+(camera._x/cellsize)))+1
    local selectedY = (math.floor((love.mouse.getY() / cellsize)+(camera._y/cellsize)))+1
    for x, row in ipairs(grid) do
      for y, collumb in ipairs(row) do
    if grid[x][y]==10 then
        love.graphics.setColor(0.4,0,0.9)
         love.graphics.rectangle('fill',(32*(x-1)),(32*(y-1)),cellsize,cellsize)
    end
    if grid[x][y]==11 then
        love.graphics.setColor(0.5,0.5,0.2)
         love.graphics.rectangle('fill',(32*(x-1)),(32*(y-1)),cellsize,cellsize)
    end
    if grid[x][y]==12 then
        love.graphics.setColor(0.0,0.5,0.1)
         love.graphics.rectangle('fill',(32*(x-1)),(32*(y-1)),cellsize,cellsize)
    end
  end
end
    
    love.graphics.setColor(1,1,1)
  end
  --[[for x,rows in ipairs(grid) do
    for y, collumb in ipairs(rows) do
      if x== selectedX and y==selectedY then 
        love.graphics.setColor(0,1,1)
      elseif collumb==1 then 
        love.graphics.setColor(0.0,1.0,0.0)
      elseif collumb==2 then
        love.graphics.setColor(0.2,0.3,0.3)
      else
        love.graphics.setColor(0.0,0.0,0.0)
      end
     
      love.graphics.rectangle('fill',(x-1)*cellsize,(y-1)*cellsize,cellsize,cellsize)
      
      for x,row in ipairs(grid)do
        for y,collumb in ipairs(row)do
          if x==selectedX and y==selectedY then
          love.graphics.print(grid[x][y],(x-1)*cellsize,(y-1)*cellsize)
          end
        end
      end
    end
  end]]
  end
end

function create_collision(map)
  local new_cols={}

  for x,rows in ipairs (map) do
    for y,collumb in ipairs (rows) do
      map[map_width][y]=1
      map[x][map_height]=1
      map[1][y]=1
      if map[x][y] == 1 then
        table.insert(new_cols, {x=(x-1)*cellsize, y=(y-1)*cellsize,tile=1})
      elseif map[x][y] == 2 then
        table.insert(new_cols, {x=(x-1)*cellsize, y=(y-1)*cellsize,tile=2})
      elseif map[x][y] == 6 then
        table.insert(new_cols, {x=(x-1)*cellsize, y=(y-1)*cellsize,tile=6})
      elseif map[x][y] == 9 then
        table.insert(new_cols, {x=(x-1)*cellsize, y=(y-1)*cellsize,tile=9})
      end
    end
  end
  cols=new_cols
end

function get_block()
  
  local selectedX = (math.floor((love.mouse.getX() / cellsize)+(camera._x/cellsize)))+1
  local selectedY = (math.floor((love.mouse.getY() / cellsize)+(camera._y/cellsize)))+1
  if selectedX>gx then
    selectedX=gx
  end
  if selectedY>gy then
    selectedY=gy
  end
  for i=0,12 do
    if selectedX <= gx and selectedY <=gy and grid[selectedX][selectedY]==i  then
      return i
  end

end
end

function new_max() 
  for i, v in ipairs(gates) do
    if v.x==playerX and v.y==playerY then
      return v.max
      
    end
  end
end
--single click mouse to change tiles 
--[[function love.mousepressed()
  if selectedX <= gx and selectedY <= gy and grid[selectedX][selectedY]==0 then
    grid[selectedX][selectedY]=1
  
  elseif selectedX <= gx and selectedY <= gy and grid[selectedX][selectedY]==1 then
    grid[selectedX][selectedY]=0
  end
  
end]]


