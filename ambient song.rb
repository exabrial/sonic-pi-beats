######################################################
# Drums
######################################################

define :boom do
  with_fx :reverb, room: 1 do
    sample :bd_boom, amp: 8
  end
  
  sample :ambi_choir, rate: 0.1
end

# 6 seconds
define :base_drums do
  with_fx :reverb, room: 0.5, phase: 0.5 do
    with_fx :echo, mix: 0.3, phase: 0.25 do
      2.times do
        sample :drum_heavy_kick, amp: 1, release: 1
        sleep 1.5
        sample :drum_snare_hard, amp: 0.3, release: 1
        sleep 1.5
      end
    end
  end
end

# 6 seconds
define :secondary_drums do
  with_fx :reverb, room: 0.5, phase: 0.5 do
    with_fx :echo, mix: 0.3, phase: 0.25 do
      sleep 1.5
      
      sample :drum_snare_hard, amp: 0.3, release: 1
      sleep 1.5
      
      sample :drum_heavy_kick, amp: 0.8, release: 1
      sleep 1.5
      
      sample :drum_snare_hard, amp: 0.5, release: 1
      sleep 0.5
      
      sample :drum_bass_soft, amp: 0.25, release: 1
      sleep 0.25
      sample :drum_bass_hard, amp: 0.75, release: 1
      sleep 0.25
      sample :drum_bass_soft, amp: 0.5, release: 1
      sleep 0.5
    end
  end
end


######################################################
# Guitar
######################################################

define :base_guitar do
  with_fx :reverb, room: 1 do
    with_fx :echo, mix: 0.3, phase: 0.25 do
      with_fx :slicer do
        sample :guit_em9, rate: 1
      end
    end
  end
end

define :secondary_guitar do
  with_fx :reverb, room: 1 do
    with_fx :pitch_shift, pitch: -12 do
      sample :guit_em9, rate: 1
    end
  end
end


######################################################
# Sounds
######################################################

define :alien_woosh do
  with_fx :reverb, room: 1 do
    sample :ambi_dark_woosh
  end
end

define :train do |s|
  with_fx :reverb, room: 0.5, phase: 0.5 do
    
    if s
      sleep 2
      end_release = 4
    else
      end_release = 6
    end
    
    use_synth :bnoise
    
    play :Cs3, amp: 0.5, pan: -1
    sleep 0.25
    play :Es3, amp: 0.25, pan: 1
    sleep 0.5
    
    play :Cs2, amp: 0.4, pan: -1
    sleep 0.25
    play :Es2, amp: 0.25, pan: 1
    sleep 0.5
    
    play :Ds3, amp: 0.3, pan: -1
    sleep 0.25
    play :Bs3, amp: 0.25, pan: 1
    sleep 0.5
    
    play :Ds2, amp: 0.3, pan: -1
    sleep 0.25
    play :Bs2, amp: 0.25, pan: 1, release: end_release
    sleep 1.5
  end
end

define :zawa do
  with_fx :reverb, room: 1 do
    with_fx :slicer do
      with_fx :pitch_shift, pitch: -12 do
        use_synth :zawa
        
        [3,5,6,7,8,10].choose.times do |i|
          play chord(:e4, :minor).choose, release: [0.2, 0.4, 0.6, 0.8, 1].choose, pan: [1,0,-1].choose, cutoff: rrand(80, 110)
          sleep [0.25,0.5,0.75].choose
        end
      end
    end
  end
end

define :burp do
  with_fx :reverb, room: 1 do
    with_fx :echo, mix: 0.3, phase: 0.25 do
      with_fx :slicer do
        with_fx :pitch_shift, pitch: 12 do
          sample :misc_burp, rate: 0.2, amp: 3
        end
      end
    end
  end
end

define :ghostly_keys do
  with_fx :reverb, room: 0.8 do
    with_fx :echo, delay: 0.5, decay: 4 do
      use_synth :dark_ambience
      play chord([:b3, :b4, :e3, :e4].choose, :minor).choose, amp: 1.5, release: 6
      
      [5,6,7,8,9,10].choose.times do |i|
        use_synth :piano
        play chord([:b1, :b2, :b3, :e1, :e2, :e3].choose, :minor).choose, cutoff: rrand(40, 100), amp: 0.75, attack: 0, release: rrand(1, 2), cutoff_max: 110, pan: [-1, 0, 1].choose
        sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
      end
    end
  end
end


######################################################
# Layers
######################################################

define :intro do
  alien_woosh
  sleep 1
end

# 6 seconds
define :base_layer do
  boom
  base_guitar
  train(true)
end

# 6 seconds
define :secondary_layer do
  in_thread do
    boom
    secondary_guitar
    zawa
  end
  
  sleep 1
  train(true)
end

# 6 seconds
define :tertiary_layer do
  in_thread do
    boom
    secondary_guitar
    zawa
  end
  
  burp
  sleep 1
  train(true)
end

# 6 seconds
define :quarternary_layer do
  in_thread do
    boom
    ghostly_keys
  end
  
  sleep 1
  train(true)
end


######################################################
# Play the song
######################################################

intro

1.times do
  base_layer
end

1.times do
  in_thread do
    base_layer
  end
  secondary_drums
end

4.times do
  in_thread do
    secondary_layer
  end
  secondary_drums
end

2.times do
  in_thread do
    tertiary_layer
  end
  secondary_drums
end

4.times do
  in_thread do
    quarternary_layer
  end
  secondary_drums
end

2.times do
  in_thread do
    base_layer
  end
  base_drums
end

2.times do
  in_thread do
    secondary_layer
  end
  secondary_drums
end

1.times do
  in_thread do
    base_guitar
    train(true)
  end
  base_drums
end

1.times do
  base_guitar
  train(true)
end

1.times do
  base_guitar
  sleep 6
end

1.times do
  with_fx :slicer, mix: 0.3 do
    base_drums
  end
end

1.times do
  with_fx :level, amp: 0.1 do
    with_fx :slicer, mix: 0.3 do
      boom
      train(false)
    end
  end
end