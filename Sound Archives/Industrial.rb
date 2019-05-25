
# Thundering Drums
live_loop :drums do
  with_fx :distortion do
    with_fx :reverb, damp: 1 do
      with_fx :lpf do
        
        32.times do
          sample :bd_tek, rate: 0.5, amp: 3 if (spread 3,12).tick
          sample :elec_snare, rate: 0.5, amp: 3 if (spread 7,12).look
          sleep 0.125
        end
      end
    end
  end
end