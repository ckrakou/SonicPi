# Heartbeat. Good for intros
live_loop :Heartbeat do
  with_fx :gverb, mix: 0.5,damp: 0.9 do
    with_fx :echo do
      sample :bd_tek, rate: 0.5, lpf: 80
      sleep 2
    end
  end
end
