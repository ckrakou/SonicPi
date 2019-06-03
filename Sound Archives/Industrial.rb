use_bpm 110

# Thundering Drums
live_loop :drums do
  with_fx :distortion, pre_amp: 0.3, distort: 0.5 do
    with_fx :reverb, damp: 1 do
      64.times do
        sample :bd_tek, rate: 0.5 ,amp: 1 if (spread 5,8).tick
        sample :elec_snare, rate: 0.5, amp: 1 if (spread 9,16).rotate(4).look
        sleep 0.25
      end
    end
  end
end

# DOOM-ish bassline
live_loop :bassline do
  with_fx :reverb, damp: 1 do
    with_fx :nrlpf, cutoff: 80, res: 0.7 do
      8.times do
        notes = (ring :c2, :d2, :e2).choose
        8.times do
          synth :prophet, note: notes, release: 0.125, sustain: 0.125, attack: 0.125 if (spread 9,16).tick
          sleep 0.25
        end
      end
    end
  end
end