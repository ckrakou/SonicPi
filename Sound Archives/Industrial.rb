use_bpm 120

# Thundering Drums
live_loop :drums do
  with_fx :distortion, distort: 0.7, pre_amp: 0.5 do
    with_fx :reverb, room: 1, damp: 1 do
      64.times do
        sample :bd_tek, amp: 1, rate: 0.5 if (spread 5,16).tick
        sample :elec_snare, amp: 1, rate: 0.5 if (spread 5,16).look
        sleep 0.25
      end
    end
  end
end

# DOOM-ish drone
live_loop :doomdrone do
  sus = (ring 0.5,1,2,3,5).choose
  with_fx :octaver do
    synth :dsaw,amp: 1, note: (chord :f2, :min).tick, sustain: sus, release: 0.125, attack: 0.125, detune: -0.2
    sleep sus
  end
end

# metallic synth melody. Normalized filters to taste.
live_loop :melody do
  chords = (ring :f4, :g4, :e4).choose
  use_random_seed 2
  with_fx :echo do
    32.times do
      synth :chiplead, note: (chord chords, :min, num_octaves: 3).choose
      sleep 0.5
    end
  end
end

# Continuous bassline. Mess with filter and controls to make it interesting
live_loop :bassline do
  use_random_seed 88
  with_fx :nrlpf, cutoff: 80, res: 0.9 do
    s = synth :tech_saws, sustain: 4, attack: 0, release: 0, note: :c3
    use_random_seed 88
    16.times do
      control s, note: (chord :c3, :min, num_octaves: 2).choose if (spread 7,16).tick
      sleep 0.25
    end
  end
end