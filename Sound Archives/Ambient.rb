# Heartbeat. Good for intros
live_loop :Heartbeat do
  with_fx :gverb, mix: 0.5,damp: 0.9 do
    with_fx :echo do
      #sample :bd_tek, rate: 0.5, lpf: 80
      sleep 2
    end
  end
end

# better choir. Adjust transpose up for angelic
live_loop :twinkle do
  with_fx :whammy, transpose: 0,grainsize: 0.25 do
    with_fx :vowel,voice: 0, vowel_sound: range(1,5,1).choose do
      sample :ambi_choir, amp: 2, beat_stretch: 8
      sleep sample_duration(:ambi_choir) * 4
    end
  end
end


