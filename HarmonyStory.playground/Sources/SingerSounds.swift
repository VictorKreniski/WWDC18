//
//  SingerSounds.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 18/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import AVFoundation

/**
 This enum has all the controllers for the sounds
 Capable of:
 returing strings to find the file
 get an AudioPlayer Instance based on a sound
 get a color based on a sound
 
 */
public enum SingerSounds: String{
    
    case acoustic11 = "Acoustic1-1", acoustic12 = "Acoustic1-2", cinematic11 = "Cinematic1-1", cinematic12 = "Cinematic1-2", cinematic21 = "Cinematic2-1", cinematic22 = "Cinematic2-2", cinematic31 = "Cinematic3-1",
    cinematic32 = "Cinematic3-2", grandPiano11 = "GrandPiano1-1", grandPiano12 = "GrandPiano1-2", liverpool11 = "Liverpool1-1", soCal11 = "SoCal1-1", soCal12 = "SoCal1-2"
    
    
    /**
     This method will get the volume based on the SingerSounds
     - parameters:
     - sound: Sound representation
     - returns: Float value between 0 - 1
     */
    public static func getVolumeValue(by sound: SingerSounds)-> Float{
        switch sound {
        case .acoustic11:
            return 0.9
        case .acoustic12:
            return 0.9
        case .cinematic11:
            return 0.7
        case .cinematic12:
            return 0.7
        case .cinematic21:
            return 0.7
        case .cinematic22:
            return 0.7
        case .cinematic31:
            return 0.7
        case .cinematic32:
            return 0.7
        case .grandPiano11:
            return 0.7
        case .grandPiano12:
            return 0.7
        case .liverpool11:
            return 1
        case .soCal11:
            return 0.8
        case .soCal12:
            return 0.8
        }
    }
    /**
     This method will return a string based on the sound
     - parameters:
     - sound: Sound representation
     - returns: String - Example: "Blue", "Red"...
     */
    public static func getColor(by sound: SingerSounds) -> String{
        switch sound {
        case .acoustic11:
            return K.Singer.Blue.name
        case .acoustic12:
            return K.Singer.Blue.name
        case .cinematic11:
            return K.Singer.Orange.name
        case .cinematic12:
            return K.Singer.Orange.name
        case .cinematic21:
            return K.Singer.Orange.name
        case .cinematic22:
            return K.Singer.Orange.name
        case .cinematic31:
            return K.Singer.Yellow.name
        case .cinematic32:
            return K.Singer.Yellow.name
        case .grandPiano11:
            return K.Singer.Green.name
        case .grandPiano12:
            return K.Singer.Green.name
        case .liverpool11:
            return K.Singer.Purple.name
        case .soCal11:
            return K.Singer.Red.name
        case .soCal12:
            return K.Singer.Red.name
        }
    }
    /**
     This method will create an AVAudioPlayer instance based on a sound
     - parameters:
     - sound: Sound representation
     - returns: AVAudioPlayer or nil if a path is wrong
     */
    public static func getAudioPlayerBased(by sound: SingerSounds)-> AVAudioPlayer?{
        guard let path: String = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") else { return nil }
        let url: URL = URL(fileURLWithPath: path)
        guard let audioPlayer: AVAudioPlayer = try? AVAudioPlayer.init(contentsOf: url) else { return nil }
        return audioPlayer
    }
}



