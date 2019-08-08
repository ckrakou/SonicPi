use_bpm 120

live_loop :drums1 do
  stop
  64.times do
    tick
    sample :bd_tek, amp: 1.2 if (spread 4,16).look
    sample :elec_blup if (spread 5,16).rotate(4).look
    sample :elec_plip if (spread 9,16).rotate(2).look
    sleep 0.25
  end
end

live_loop :drums2 do
  stop
  with_fx :distortion do
    64.times do
      tick
      sample :drum_bass_hard, amp: 0.6, hpf: 45, finish: 0.5 if (spread 4,16).look
      sample :drum_tom_lo_hard, amp: 0.6, hpf: 45, lpf: 90, finish: 0.2 if (spread 5,16).rotate(4).look
      
      sleep 0.25
    end
  end
end

live_loop :clean do
  stop
  64.times do
    tick
    synth :tb303, amp: 0.3, release: 0.125, note: :c1, cutoff: line(60,90,steps: 64,inclusive: true).mirror.look
    sleep 0.25
  end
end

live_loop :ixis do
  stop
  with_fx :ixi_techno, phase: 8 do
    64.times do
      tick
      # Also works with dsaw
      synth :prophet, amp: 0.8, note: (chord :c3, :min, invert: range(-1,3,1).choose), sustain: 4, cutoff: 80 if (spread 1,16).look
      
      sample :elec_twang, amp: 0.5, pan: line(-1,1,steps: 8, inclusive: true).mirror.look if (spread 15,16).look
      
      sleep 0.25
    end
  end
end

live_loop :slices do
  stop
  with_fx :slicer do
    64.times do
      tick
      synth :prophet, amp: 0.9, note: (scale :c3, :minor).choose, cutoff: 80, sustain: 4 if (spread 1,16).look
      
      sample :bass_trance_c, amp: 0.9, lpf: 80, slice: range(1,8,1).choose
      
      sample :ambi_lunar_land, amp: 0.8, rpitch: (chord :c0, :minor).choose - 24, slice: (ring 2,3,4).choose if (spread 4,16).look
      sleep 0.25
    end
  end
end

live_loop :echoes do
  stop
  with_fx :echo do
    64.times do
      tick
      
      # use alone without pan, or pair with opposing pan pan
      sample :bass_trance_c, slice: 0, hpf: 60, rpitch: (chord :c0, :minor).choose, amp: 0.6, pan: line(-1,1,steps: 16,inclusive: true).mirror.look if (spread 7,16).look
      
      
      sleep 0.25
    end
  end
end

live_loop :flanges do
  stop
  with_fx :flanger do
    64.times do
      tick
      
      
     
      # Works as a pair
      synth :chipbass, amp: 0.7, note: (scale :c3, :minor).choose, release: 0.25
      synth :fm, amp: 0.8, note: (chord :c3, :minor).choose, sustain: 4 if (spread 1,16).look
      sleep 0.25
    end
  end
end

live_loop :krushes do
  stop
  with_fx :krush, mix: 0.25, cutoff: 90 do
    64.times do
      tick
      synth :pretty_bell, note: (chord :c3, :minor).choose, release: 0.5
      sleep 0.25
    end
  end
end


# Works with a lot of effects like Echo, Krush, Slicer, Ixi
# Normaliser makes it even gnarlier
live_loop :gnarlyBass do
  stop
  
  pitches = (chord :a0, :minor).choose - 32
  
  with_fx :gverb, damp: 1 do
    64.times do
      tick
      
      if (spread 7,16).look then
        sample :bass_hard_c, slice: pick, rpitch: pitches
      elsif (spread 5,16).rotate(3).look then
        sample :bass_drop_c, slice: pick, rpitch: pitches
      end
      
      sleep 0.25
    end
  end
end


