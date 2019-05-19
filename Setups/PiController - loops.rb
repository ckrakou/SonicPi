live_loop :loop1 do
  if (get(:toggle1) == 1) then
    
  else
    sleep 1
  end
end

live_loop :loop2 do
  if (get(:toggle2) == 1) then
    
  else
    sleep 1
  end
end

live_loop :loop3 do
  if (get(:toggle3) == 1) then
    
  else
    sleep 1
  end
end

live_loop :loop4 do
  if (get(:toggle4) == 1) then
    
  else
    sleep 1
  end
end

live_loop :cues do
  cue :bar
  16.times do
    cue :step
    sleep 0.25
  end
end
