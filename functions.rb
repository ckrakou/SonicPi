
# randomised movement of a chord. Based on youtube video about hollywood music
define :movement do |col,dist|
  col.each_with_index do |x,i|
    col = col.put(i,x + dist*range(-1,1,1).choose)
  end
  return col
end


