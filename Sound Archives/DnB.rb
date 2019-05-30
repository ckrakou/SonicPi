use_bpm 170

live_loop :kickSetter do
  set :kicks, (ring
               (spread 1.375,8).take_last(4),
               (spread 1.375,8).drop_last(4),
               (spread 2.75,16),
               ).tick
  sleep 4
end

live_loop :drums do
  with_fx :reverb do
    64.times do
      sample :bd_haus if get(:kicks).tick
      sample :sn_zome, amp: 0.5 if (spread 2,16).rotate(0).look
      sample :elec_cymbal, amp: 0.3 if (spread 9,16).look
      sleep 0.25
    end
  end
end

live_loop :bassline do
  temp = (ring 1,2,3,5).choose
  with_fx :wobble, phase: temp, cutoff_max: 110, cutoff_min: 80, res: 0.9 do
    synth :supersaw, sustain: temp, note: (chord :a1,:min, num_octaves: 2).choose, amp: 0.5, attack: 0.025, release: 0
    sleep temp
  end
end


