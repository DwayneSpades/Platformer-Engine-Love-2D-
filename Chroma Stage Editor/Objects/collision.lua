function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)

 


  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
function SAT(box1,box2)
    --Pseudo code to evaluate the separation of box1 and box2
h_length = box2.x-12 - box1.x-16;
half_width_box1= box1.w*0.5;
half_width_box2= box2.w*0.5;
 
gap_between_boxes= h_length - half_width_box1 - half_width_box2;

end
function sphere_rec(sphere1x,sphere1y,sphere1r,recx,recy,recw,rech)
local DeltaX = sphere1x - math.max(recx, math.min(sphere1x, recx + recw));
local DeltaY = sphere1y - math.max(recy, math.min(sphere1y, recy+ rech));
return (DeltaX * DeltaX + DeltaY * DeltaY) < (sphere1r * sphere1r) 
  
end
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end