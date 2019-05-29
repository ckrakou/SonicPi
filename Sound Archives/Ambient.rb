# Heartbeat. Good for intros
live_loop :Heartbeat do
  with_fx :gverb, mix: 0.5,damp: 0.9 do
    with_fx :echo do
      sample :bd_tek, rate: 0.5, lpf: 80
      sleep 2
    end
  end
end

# better choir. Adjust transpose up for angelic. really quiet
live_loop :choir do
  with_fx :whammy,amp: 5, transpose: 12,grainsize: 0.25 do
    with_fx :vowel,pre_amp: 5,voice: 0, vowel_sound: range(1,5,1).choose do
      sample :ambi_choir, amp: 1, beat_stretch: 8
      sleep sample_duration(:ambi_choir) * 4
    end
  end
end

# Organ. Flanger gives it more body. Season with resonance
# Works well with beep, tb303, supersaw, techsaw, fm
live_loop :organ do
  with_fx :gverb, mix: 0.25, amp: 0.5 do
    with_fx :flanger do
      with_fx :octaver do
        synth :fm, note: (chord :c4, :augmented).choose, sustain: 8, attack: 1, release: 1, amp: 1
        sleep 9
      end
    end
  end
end

