import Foundation

//
//  AVSpeechManager.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 29/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import AVFoundation

/**
 This protocol can be adopted only by a class

  And requires speakerDidFinished implementation
 
 */
public protocol AVSpeechManagerDelegate: class {
    
    func speakerDidFinished()
}
/**
 This Class is responsable for managing all the AVSpeech
 
 Gives you control over:
    When it says
    What it reads
    Delegate to know when the reading has finished
 
 */
public final class AVSpeechManager: NSObject {
    
    /// Responsable for carrying the instance to say the text
    public var utterance: AVSpeechUtterance?
    
    /// The voice choosen to read all the texts
    private var voiceChoosen: AVSpeechSynthesisVoice?
    
    /// Responsable for syntesizing the speech
    public var syntesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    /// To delegate responsability of the protocol method
    /// Its good practice to declare delegates as weak to avoid strong reference
    public weak var aVSpeechManagerDelegate: AVSpeechManagerDelegate?
    
    /**
     This method will initiate one instance of AVSpeechManager
     - parameters:
     - text: The text it will be played on the first readText
     */
    public init(text: String) {
        
        let voices: [AVSpeechSynthesisVoice] = AVSpeechSynthesisVoice.speechVoices()
        for voice in voices{
            if voice.name == "Samantha (Enhanced)" && voice.quality == .enhanced {
                self.voiceChoosen = voice
            }
        }
        super.init()
        self.changeUtterance(text: text)
        self.syntesizer.delegate = self
        self.syntesizer.pauseSpeaking(at: .word)
        
    }
    
    /**
     This method will read the text in the utterance
     */
    public func readText(){
        if let utterance: AVSpeechUtterance = self.utterance {
            self.syntesizer.speak(utterance)
        }
    }
    /**
     This method will change the utterance to a new text
     - parameters:
     - text: the new text the utterance will have
     */
    public func changeUtterance(text: String){
        self.utterance = AVSpeechUtterance(string: text.lowercased())
        self.utterance?.volume = 0.8
        self.utterance?.rate = 0.4
        self.utterance?.pitchMultiplier = 1
    }
    
    
}
/**
 Implementation of the AVSpeechSynthesizerDelegate
 */
extension AVSpeechManager: AVSpeechSynthesizerDelegate{
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.aVSpeechManagerDelegate?.speakerDidFinished()
    }
}

