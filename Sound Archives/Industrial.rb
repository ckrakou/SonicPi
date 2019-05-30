# Thundering Drums
live_loop :drums do
  with_fx :distortion, distort: 0.5 do
    with_fx :reverb, damp: 1 do
      64.times do
        sample :bd_tek, rate: 0.5 ,amp: 1 if (spread 9,12).tick
        sample :elec_snare, rate: 0.5, amp: 1 if (spread 7,12).look
        sleep 0.125
      end
    end
  end
end
