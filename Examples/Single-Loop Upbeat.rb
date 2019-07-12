use_bpm 120

# Core Structure
live_loop :main do
  stop
  64.times do
    tick
    
    
    sleep 0.25
  end
end

# simple rythm w. euclidian algorithms and rotations
live_loop :main2 do
  stop
  64.times do
    tick
    sample :bd_tek if (spread 7, 16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread 9,16).rotate(2).look
    sleep 0.25
  end
end

# With generative rythms. Messing with iterations for extra goodness
# Keep the snare stable, otherwise it gets confusing.
live_loop :main3 do
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    sleep 0.25
  end
end

# Adding a bassline w. generated pitch
live_loop :main4 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    sample :bass_trance_c, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Lets add a happy little lead
live_loop :main4 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  lead_root = (scale :c4, :minor_pentatonic).choose # keep the lead interesting, since we tick tough it
  
  (ring 16,32,64).choose.times do
    tick
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    
    synth :supersaw, amp: 0.5, note: (chord lead_root, :minor7).look, cutoff: cut
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    sample :bass_trance_c, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Finally, let's add some nice effects.
# Adding effects like this is really taxing, so be careful.
live_loop :main4 do
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  lead_root = (scale :c4, :minor_pentatonic).choose # keep the lead interesting, since we tick tough it
  
  (ring 16,32,64).choose.times do
    tick
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    lead_notes = (chord lead_root, :minor7) #  Let's keep these here, since we need it for 2 things
    
    # Soften up the sound
    with_fx :bpf, centre: lead_notes[2] do
      synth :supersaw, amp: 1, note: lead_notes.look, cutoff: cut
    end
    
    # Add a bit of punch to the drums
    with_fx :reverb, room: 1, damp: 1 do
      sample :bd_tek if (spread kicks,16).look
      sample :elec_snare if (spread 2,16).rotate(4).look
      sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    end
    
    # Make the bassline more interesting
    with_fx :flanger, delay: 0 do
      sample :bass_trance_c, rpitch: bass_pitch if (spread 1,16).look
    end
    sleep 0.25
  end
end
