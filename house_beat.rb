use_bpm 122

live_loop :bass_drum do
  # mark the 4 count of the song with emphasis on 1 and 4
  # beat 1
  sample :drum_heavy_kick
  sample :bd_klub
  sleep (1)
  
  # beat 2
  sample :drum_heavy_kick
  sleep (1)
  
  # beat 3
  sample :drum_heavy_kick
  sleep (1)
  
  # beat 4
  sample :drum_heavy_kick
  sample :bd_klub
  sleep (1)
end

live_loop :snare do
  # snare hits on beat 2 and 4
  with_fx :reverb do
    sleep (1)
    sample :drum_snare_soft
    sleep (1)
    sleep (1)
    sample :drum_snare_soft
    sleep (1)
  end
end

live_loop :offset_hats do
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

live_loop :moving_high_hat do
  # add offset highhat that moves cyclicaly around the beat every 4 measures
  sleep 3.25
  sample :drum_cymbal_closed
end

live_loop :emphasis_hat do
  # add extra high hat that falls regularly
  sleep 3.75
  sample :drum_cymbal_closed
  sleep 1.25
end

live_loop :mark8 do
  sleep 7
  sample :ambi_dark_woosh
  sleep 1
end

live_loop :mark16 do
  sleep 15
  sample :ambi_soft_buzz
  sleep 1
end

live_loop :mark32 do
  sleep 31
  with_fx :reverb do
    sample :ambi_haunted_hum
  end
  sleep 1
end

define :chord_player do |root, repeats|
  repeats.times do
    play chord(root, :minor), release: 0.3
    sleep 0.5
  end
end

define :chord_thing do
  with_fx :reverb do
    with_fx :reverb do
      with_fx :reverb do
        # total beats: 12
        chord_player :e3, 4
        sleep 1
        chord_player :a3, 1
        sleep 2
        chord_player :d3, 2
        sleep 1
        chord_player :d3, 1
        sleep 1
        chord_player :e3, 4
        sleep 1
      end
    end
  end
end

live_loop :chords_loop do
  sleep 1
  chord_thing
  sleep 4
end

live_loop :mark128 do
  sleep 127
  sample :ambi_lunar_land
  sleep 1
end

