use_bpm 120

# Core Structure. This is the basis for our loops
# If you have more than one loop, make sure to synchronize them
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
    
    # this is our bass drum rythm. we'll do 7 hits over 16 steps.
    # to say it in a way that is a bit easier to read, our rythm is: "*__*_*_*_*__*_*_*_"
    kick_rythm = (ring true, false, false, true, false, true, false, true, false, false, true, false ,true, false, true, false)
    
    if kick_rythm.look == true then
      sample :bd_tek if (spread 7, 16).look
    end
    
    
    # We can use the spread function to generate this list for us
    # This gives us 2 hits spread evenly over 16 hits, and rotates the list 4 times
    # giving us this: ____*_______*___
    # Since it's short and concise, we'll put it straight in the "if" statement
    if (spread 2,16).rotate(4).look then
      sample :elec_snare
    end
    
    # Adding the if-statement to the end does the same thing as the normal "if" structure
    # We'll use the short form for the rest of the example. It's faster to write out.
    sample :drum_cymbal_closed if (spread 9,16).rotate(2).look
    sleep 0.25
  end
end

# With generative rythms. Messing with iterations for extra goodness
# Keep the snare stable, otherwise it gets confusing.
live_loop :main3 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  
  # let's vary the number of iterations, to make it extra snappy
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    sleep 0.25
  end
end

# Adding a bassline w. generated pitch. This is going to form the
# basis of our soundscape.
live_loop :main4 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # let's change up the pitch of the bass.
  
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    sample :bass_trance_c, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Let's do a bit of mastering, since we're beginning to sound
# a bit muddled and messy. We don't want that.
# samples like to take up a lot of space. Let's clean that out.
# We'll use filters to do that. High-pass (hpf) and Low-pass (lpf)
# We'll also adjust the amplitude of each sample.
live_loop :main5 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    
    # Filter out the high frequencies on our snare.
    sample :elec_snare, lpf: 90 if (spread 2,16).rotate(4).look
    
    # Filter out the low frequencies on our cymbals.
    sample :drum_cymbal_closed, hpf: 45 if (spread cymbals,16).rotate(2).look
    
    # Adjust the volume of our bass, so it doesn't overpower the others.
    sample :bass_trance_c, amp: 0.9, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Lets add a happy little lead. Leads live in the higher frequencies
# so make sure you keep the notes high. We want them to stand out.
live_loop :main6 do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  lead_root = (scale :c4, :minor_pentatonic) # keep the lead interesting, since we tick tough it
  
  (ring 16,32,64).choose.times do
    tick
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    
    # Our lead plays the same note, and the changing cutoff keeps it
    # nice and interesting. You could iterate through chords instead
    synth :supersaw, amp: 0.8, note: lead_root.look, cutoff: cut
    
    
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare, lpf: 90 if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed, hpf: 45 if (spread cymbals,16).rotate(2).look
    sample :bass_trance_c, amp: 0.9, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Finally, let's add some nice effects.
# Adding effects like this is really taxing on your computer
# so be careful. You might want to separate your sounds into several loops.
live_loop :final do
  stop
  kicks = (ring 5,7,9).choose # get our kicks
  cymbals = (ring 9,11,13).choose # Generate cymbal rythms
  bass_pitch = (scale :c0, :minor).choose - 12   # Adjusted to account for the pitch of the bass sample
  lead_root = (scale :c4, :minor_pentatonic).choose # keep the lead interesting, since we tick tough it
  
  (ring 16,32,64).choose.times do
    tick
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    lead_notes = (chord lead_root, :minor7) #  Let's keep these here. Easier to read the code
    
    # Soften up the sound
    with_fx :bpf, centre: lead_notes[2] do
      synth :supersaw, amp: 0.8, note: lead_notes.look, cutoff: cut
    end
    
    # Add a bit of punch to the drums
    with_fx :reverb, room: 1, damp: 1 do
      sample :bd_tek if (spread kicks,16).look
      sample :elec_snare, lpf: 90 if (spread 2,16).rotate(4).look
      sample :drum_cymbal_closed, hpf: 45 if (spread cymbals,16).rotate(2).look
    end
    
    # Make the bassline more interesting
    with_fx :flanger, delay: 0 do
      sample :bass_trance_c, amp: 0.9, rpitch: bass_pitch if (spread 1,16).look
    end
    sleep 0.25
  end
end
