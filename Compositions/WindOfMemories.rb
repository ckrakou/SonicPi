use_bpm 120

live_loop :winds do
  4.times do
    with_fx :panslicer, phase: 12, wave: 2, phase_offset: rrand(0,1) do
      synth :noise, attack: 3, sustain: 4, release: 5, cutoff: rrand(70,85)
      sleep 12
    end
  end
end

live_loop :swish do
  with_fx :slicer, amp: 1.5, mix: line(0,1,steps: 32, inclusive: true).ramp.tick do
    sample :ambi_lunar_land, pitch_stretch: 12, pitch: rrand(-5,5)
    sleep 8
  end
end

live_loop :bass, sync: "/live_loop/winds" do
  
  6.times do
    inversions = (ring 0,0,-1,2,1,2).tick
    12.times do
      synth :chipbass, note: (chord :cs3, :minor).tick, sustain: 0.5, amp: line(0,1,steps: 72, inclusive: true).ramp.look
      sleep 0.5
    end
  end
end

live_loop :drone, sync: "/live_loop/bass" do
  
  with_fx :reverb do
    with_fx :bpf, centre: (scale :cs4, :minor)[4] do
      synth :dsaw, note: (scale :cs4, :minor).choose, sustain: 4, amp: line(0,1,steps: 10, inclusive: true).ramp.tick
      sleep 4
    end
  end
end
