use_bpm 124
high_hat_level = 0.3
extra_samples="/Users/jonathanfisher/dev/sonic-pi-beats/extra_samples"


live_loop :mark128 do
  sync :bass_drum
  with_fx :level, amp: 1.25 do
    sleep 126
    sample :ambi_lunar_land
    sleep 2
  end
end


kick_enabled = true

live_loop :bass_drum do
  with_fx :level, amp: 0.85  do
    # mark the 4 count of the song with emphasis on 1 and 4
    # beat 1
    if kick_enabled then
      sample :drum_heavy_kick
      sample :bd_klub, amp: 0.75
    end
    sleep (1)
    
    # beat 2
    if kick_enabled then
      sample :drum_heavy_kick
    end
    with_fx :reverb, room: 0.85 do
      sample extra_samples, :hand_clap, amp: 1.25
    end
    sleep (1)
    
    # beat 3
    if kick_enabled then
      sample :drum_heavy_kick
    end
    sleep (1)
    
    # beat 4
    if kick_enabled then
      sample :drum_heavy_kick
      sample :bd_klub, amp: 0.75
    end
    with_fx :reverb, room: 0.85 do
      sample extra_samples, :hand_clap, amp: 1.25
    end
    sleep (1)
  end
end

live_loop :hats_and_snares do
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 1
  sample :drum_cymbal_closed
  sleep 1
  sample :drum_cymbal_closed
  sleep 1
  sample :drum_cymbal_closed
  sleep 0.5
end

live_loop :emphasis_hat do
  sync :bass_drum
  with_fx :level, amp: high_hat_level do
    sleep 3.75
    sample :drum_cymbal_closed
    sleep 0.25
  end
end


define :chord_player do |root, repeats|
  repeats.times do
    play chord(root, :minor), release: 0.3
    sleep 0.5
  end
end

bass_enabled=true
e_enabled=true

live_loop :chord do
  sync :bass_drum

  sleep 0.5
  if e_enabled then
    play chord(:e3, :minor), release: 0.3
  end
  if bass_enabled then
    play note(:e2), release: 0.5, amp: 1.5
  end

  sleep 1
  if e_enabled then
    play chord(:e3, :minor), release: 0.3
  end
  if bass_enabled then
    play note(:e2), release: 0.5, amp: 1.5
  end

  sleep 1
  if e_enabled then
    play chord(:e3, :minor), release: 0.3
  end
  if bass_enabled then
    play note(:e2), release: 0.5, amp: 1.5
  end

  sleep 1.5
  if e_enabled then
    play chord(:e3, :minor), release: 0.3
  end
  if bass_enabled then
    play note(:e2), release: 0.5, amp: 1.5
  end

  sleep 0.5
  if e_enabled then
    play chord(:e3, :minor), release: 0.3
  end
  if bass_enabled then
    play note(:e2), release: 0.5, amp: 1.5
  end
end
