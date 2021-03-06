use_bpm 124

live_loop :bass_drum do
  with_fx :level, amp: 0.85  do
    # mark the 4 count of the song with emphasis on 1 and 4
    # beat 1
    sample :drum_heavy_kick
    with_fx :level, amp: 0.75  do
      sample :bd_klub
    end
    sleep (1)
    
    # beat 2
    sample :drum_heavy_kick
    sleep (1)
    
    # beat 3
    sample :drum_heavy_kick
    sleep (1)
    
    # beat 4
    sample :drum_heavy_kick
    with_fx :level, amp: 0.75  do
      sample :bd_klub
    end
    sleep (1)
  end
end

live_loop :snare do
  sync :bass_drum
  # snare hits on beat 2 and 4
  with_fx :level, amp: 0.5  do
    with_fx :reverb, room: 0.5 do
      sleep (1)
      sample :drum_snare_soft
      sleep (1)
      sleep (1)
      sample :drum_snare_soft
      sleep (1)
    end
  end
end

high_hat_level = 0.3

live_loop :offset_hats do
  sync :bass_drum
  with_fx :level, amp: high_hat_level do
    # these fall on the offbeats but count the beat of the song
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
end

live_loop :moving_high_hat do
  sync :bass_drum
  with_fx :level, amp: high_hat_level do
    # add offset highhat that moves cyclicaly around the beat with a period of 12 measures
    sleep 3.25
    sample :drum_cymbal_closed
  end
end

live_loop :emphasis_hat do
  sync :bass_drum
  with_fx :level, amp: high_hat_level do
    # add extra high hat that falls regularly
    sleep 3.75
    sample :drum_cymbal_closed
    sleep 1.25
  end
end

live_loop :mark8 do
  sync :bass_drum
  sleep 7
  sample :ambi_dark_woosh
  sleep 1
end

live_loop :mark16 do
  sync :bass_drum
  with_fx :level, amp: 0.85 do
    sleep 15
    sample :ambi_soft_buzz
    sleep 1
  end
end

live_loop :mark32 do
  sync :bass_drum
  with_fx :level, amp: 0.65 do
    with_fx :reverb, room: 0.85 do
      sleep 31
      sample :ambi_haunted_hum
      sleep 1
    end
  end
end

define :chord_player do |root, repeats|
  repeats.times do
    play chord(root, :minor), release: 0.3
    sleep 0.5
  end
end

define :chord_thing do
  with_fx :reverb, room: 1.0 do
    # total beats: 12
    # you can move the timings around
    # as long as the count doesn't exceed 12
    chord_player :e3, 4
    sleep 0.5
    chord_player :a3, 1
    sleep 2
    chord_player :d3, 2
    sleep 1
    chord_player :d3, 1
    sleep 0.5
    chord_player :e3, 5
    sleep 1.5
  end
end

live_loop :mark16 do
  sync :bass_drum
  sleep 1
  chord_thing # this takes 12 beats to execute
  sleep 3
end

live_loop :mark128 do
  sync :bass_drum
  with_fx :level, amp: 1.25 do
    sleep 126
    sample :ambi_lunar_land
    sleep 2
  end
end

