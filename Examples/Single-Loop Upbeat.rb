use_bpm 120

# Core Structure. This is the basis for our loops
# To hear each loop, put a # in from of "stop" and run the code.
live_loop :main do
  stop
  64.times do
    tick
    
    sleep 0.25
  end
end

# Let's make some rhythms for our samples
# We'll use the euclidean algorithm to quickly create some rhythms
live_loop :main2 do
  stop
  64.times do
    tick
    
    # this is our bass drum rythm. we'll do 7 hits over 16 steps.
    # to say it in a way that is a bit easier to read, our rythm is: "*__*_*_*__*_*_*_"
    kick_rhythm = (ring true, false, false, true, false, true, false, true, false, false, true, false, true, false, true, false)
    
    if kick_rhythm.look == true then
      sample :bd_tek
    end
    
    # Let's save our snare pattern, which is 2 hits evenly spread over 16 steps
    # giving us this: *_______*_______
    snare_rhythm = (ring true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false)
    
    
    # We can use the spread function to generate this list for us instead of writing it out
    # This gives us 2 hits spread evenly over 16 steps.
    snare_rhythm = (spread 2,16)
    
    # because it's so much shorter, we can put it directly in the "if" statement.
    if (spread 2,16).look then
      sample :elec_snare
    end
    
    # We can also shift our rhytms by adding .rotate() at the end of the spread function
    # imagine it as taking the last element and putting it in the front of the list
    # the number in the parenthesis is how many times it does this.
    # This one gives us the following pattern: *_*_*_**_*_*_**_
    cymbal_rhythm = (spread 9,16).rotate(2)
    
    # Adding the if-statement to the end works the same as the normal "if" structure
    # We'll use this short form for the rest of the examples. It's faster to write out.
    
    # If we put it all together, we can write our cymbal rhythms as just one line of code
    sample :drum_cymbal_closed if (spread 9,16).rotate(2).look
    sleep 0.25
  end
end

# Let's get crazy and generate some random rhythms. We'll use .choose instead of .look for this.
# We'll save the number of hits in a separate list, and pick one for each iteration
# We'll keep the snare at 2 hits per 16 steps, rotated by 4. Otherwise it gets too chaotic
live_loop :main3 do
  stop
  kicks = (ring 5,7,9).choose # These are our kicks
  cymbals = (ring 9,11,13).choose # These are our cymbals
  
  # let's vary the number of iterations, to make it extra snappy
  (ring 16,32,64).choose.times do
    tick
    # Notice how we're using the variable in place of the numbers
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
  kicks = (ring 5,7,9).choose # These are our kicks
  cymbals = (ring 9,11,13).choose # These are our cymbals
  
  # We'll use a scale to generate our bass pitches
  # We could use a chord if we wanted to. Just make sure to start at 0
  bass_pitch = (scale 0, :minor).choose
  
  (ring 16,32,64).choose.times do
    tick
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed if (spread cymbals,16).rotate(2).look
    
    # we'll use the rpitch function to change the pitch of the bass sample.
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
  kicks = (ring 5,7,9).choose # These are our kicks
  cymbals = (ring 9,11,13).choose # These are our cymbals
  bass_pitch = (scale 0, :minor).choose # Our bass pitch
  
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
  kicks = (ring 5,7,9).choose # These are our kicks
  cymbals = (ring 9,11,13).choose # These are our cymbals
  bass_pitch = (scale 0, :minor).choose # Our bass pitch
  
  # This is the note for our lead. We'll generate these as well, to keep it more interesting
  lead_note = (scale :c4, :minor_pentatonic).choose
  
  (ring 16,32,64).choose.times do
    tick
    
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    
    # Our lead plays the same note, and the changing cutoff keeps it
    # nice and interesting. You could iterate a chord instead
    synth :supersaw, amp: 0.8, note: lead_note, cutoff: cut
    
    
    sample :bd_tek if (spread kicks,16).look
    sample :elec_snare, lpf: 90 if (spread 2,16).rotate(4).look
    sample :drum_cymbal_closed, hpf: 45 if (spread cymbals,16).rotate(2).look
    sample :bass_trance_c, amp: 0.9, rpitch: bass_pitch if (spread 1,16).look
    sleep 0.25
  end
end

# Finally, let's add some nice effects.
# Adding effects like this can be really taxing on your computer
# so be careful. You might want to separate your sounds into several loops.
live_loop :final do
  #stop
  kicks = (ring 5,7,9).choose # These are our kicks
  cymbals = (ring 9,11,13).choose # These are our cymbals
  bass_pitch = (scale 0, :minor).choose # Our bass pitch
  lead_notes = (scale :c4, :minor_pentatonic).choose # Our lead notes
  
  (ring 16,32,64).choose.times do
    tick
    # Poor mans LFO.
    cut = line(70,110,steps: 32, inclusive: true).mirror.look
    
    # Soften up the sound a bit with a band pass filter
    # We'll loop through a chord as well instead of just playing the lead note
    # Just to keep things interesting. The lead note becomes the root of our chord.
    with_fx :bpf, centre: lead_notes, amp: 1.2 do
      synth :supersaw, amp: 0.8, note: (chord lead_notes, :minor).look, cutoff: cut
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
