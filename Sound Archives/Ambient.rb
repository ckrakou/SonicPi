# Heartbeat. Good for intros
live_loop :Heartbeat do
  with_fx :gverb, mix: 0.5,damp: 0.9 do
    with_fx :echo do
      16.times do
        sample :bd_tek, amp: 1, rate: 0.5, lpf: 80
        sleep 2
      end
    end
  end
end

# Ghostly choir. Adjust transpose up for angelic. really quiet
live_loop :choir do
  with_fx :echo, amp: 3 do
    with_fx :vowel, amp: 3,voice: 0, vowel_sound: range(1,5,1).choose do
      16.times do
        sample :ambi_choir, amp: 1, beat_stretch: 8, attack: 0.25
        sleep sample_duration(:ambi_choir) * 4
      end
    end
  end
end

# Organ. Flanger gives it more body. Season with resonance
# Works well with beep, tb303, supersaw, fm, chipbass
live_loop :organ do
  with_fx :flanger do
    with_fx :octaver, amp: 0.75 do
      16.times do
        synth :chipbass, amp: 1, note: (chord :c3, :augmented).choose, sustain: 8, attack: 1, release: 1, amp: 1
        sleep 8
      end
    end
  end
end

# Mix with whammy for trickles
live_loop :radio do
  with_fx :echo do
    64.times do
      sample :ambi_glass_rub,amp: 1, slice: pick, pan: rrand(-1,1)
      sleep (ring 0.5,0.25,1).choose
    end
  end
end