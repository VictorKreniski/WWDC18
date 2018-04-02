//
//  Singer.swift
//  KreviHarmony
//
//  Created by Victor Oliveira Kreniski on 15/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit
import AVFoundation



/*
 
 Class to represent Singer object in the class
 
 */
public final class Singer: GameObject, Sing {
    
    /// Finite state machine to control actions
    var finiteStateMachine: FiniteStateMachine<SingerStates, SingerActions>?
    
    /// AudioPlayer to control the sound this singer plays
    var audioPlayer: AVAudioPlayer?
    
    /// Sound to know wich instrument this singer is going to play
    var sound: SingerSounds
    
    /// Container of all textures
    var texturesContainer: SingerTexturesContainer?
    
    /**
     This method will init a singer
     - parameters:
     - position: Position in scene
     - size: The size of the singer
     - sound: The sound this singer is going to play
     */
    public init(position: CGPoint,size: CGSize, sound: SingerSounds ) {
        self.sound = sound
        self.texturesContainer = SingerTextureContainerManager.getContainerByColour(named: SingerSounds.getColor(by: self.sound))
        if let texture = self.texturesContainer?.idleTextures.first {
            super.init(position: position,texture: texture,size: size)
        }else {
            super.init(position: position, texture: SKTexture(), size: size)
        }
        self.name = K.Singer.nodeName
        self.setupStatesForFiniteStateMachine()
        self.audioPlayer = SingerSounds.getAudioPlayerBased(by: sound)
        self.audioPlayer?.volume = SingerSounds.getVolumeValue(by: sound)
        self.audioPlayer?.numberOfLoops = -1 // loop forever
        self.audioPlayer?.prepareToPlay()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     This method will reset the audioPlayer
     */
    private func resetAudioPlayer(){
        self.changeAudioPlayerVolumeToZero()
        self.stopAudioPlayer()
        self.resetAudioPlayerCurrentTimeToStart()
    }
    /**
     This method will stop the audio
     */
    private func stopAudioPlayer(){
        self.audioPlayer?.stop()
    }
    
    /**
     This method will set the volume to 0 - Muted
     */
    private func changeAudioPlayerVolumeToZero(){
        self.audioPlayer?.volume = 0.0

    }
    /**

     This method will reset the audioPlayer current times
     
     */
    private func resetAudioPlayerCurrentTimeToStart(){
        self.audioPlayer?.currentTime = 0.0
    }
    /**

     This method will make the singer sing his sound at one specif moment
     - parameters:
     - currentTime: the moment this method was called
     - delay: How much time must be waited before singing the sound
     */
    public func sing(currentTime: TimeInterval, delay: TimeInterval) {
        let totalTime: TimeInterval = currentTime + delay
        if self.finiteStateMachine?.currentState == SingerStates.muted {
            self.changeAudioPlayerVolumeToZero()
            self.playAtTime(at: totalTime)
        } else if self.finiteStateMachine?.canExecute(action: SingerActions.idleToSinging) ?? false{
            self.finiteStateMachine?.execute(action: SingerActions.idleToSinging)
            self.audioPlayer?.volume = SingerSounds.getVolumeValue(by: self.sound)
            self.playAtTime(at: totalTime)
            self.playAnimationSinging()
        }
    }
    /**

     If valid, will make the singer to stop singing
     
     */
    public func stopSinging(){
        if self.finiteStateMachine?.canExecute(action: SingerActions.singingToIdle) ?? false{
            self.finiteStateMachine?.execute(action: SingerActions.singingToIdle)
            self.resetAudioPlayer()
            self.playAnimationIdle()
        } else if self.finiteStateMachine?.currentState == SingerStates.muted {
            self.resetAudioPlayer()
        }
        
    }
    /**
     This method is used to sync all the sounds.
     - parameters:
     - time: the moment the music will be played.
     */
    private func playAtTime(at time: TimeInterval){
        self.audioPlayer?.play(atTime: time)
    }
    
    /**

     Order the singer to change it state
     
     */
    public func orderToChange(){
        if self.finiteStateMachine?.canExecute(action: SingerActions.singingToMuted) ?? false {
            self.finiteStateMachine?.execute(action: SingerActions.singingToMuted)
            self.changeAudioPlayerVolumeToZero()
            self.playAnimationMuted()
        } else if self.finiteStateMachine?.canExecute(action: SingerActions.mutedToSinging) ?? false {
            if let playing: Bool = self.audioPlayer?.isPlaying{
                if playing{
                    self.finiteStateMachine?.execute(action: SingerActions.mutedToSinging)
                    self.audioPlayer?.volume = SingerSounds.getVolumeValue(by: self.sound)
                    self.playAnimationSinging()
                } else if self.finiteStateMachine?.canExecute(action: SingerActions.idleToMuted) ?? false {
                    self.finiteStateMachine?.execute(action: SingerActions.idleToMuted)
                    self.changeAudioPlayerVolumeToZero()
                    self.playAnimationMuted()
                } else if self.finiteStateMachine?.canExecute(action: SingerActions.mutedToIdle) ?? false{
                    self.finiteStateMachine?.execute(action: SingerActions.mutedToIdle)
                    self.resetAudioPlayer()
                    self.playAnimationIdle()
                }
            }
        } else if self.finiteStateMachine?.canExecute(action: SingerActions.idleToMuted) ?? false {
            self.finiteStateMachine?.execute(action: SingerActions.idleToMuted)
            self.changeAudioPlayerVolumeToZero()
            self.playAnimationMuted()
        }
    }
    
    /*
     
     Will randomize the animation idle
     
     */
    private func playAnimationIdle(){
        let randomInt: Int = Int.randomBetween(lowerValue: 0, maxValue: K.Singer.Muted.numberOfSprites)
        switch randomInt {
        case 0:
            self.playAnimationNormal()
        case 1:
            self.playAnimationNormal()
        case 2:
            self.playAnimationSmile()
        case 3:
            self.playAnimationLooking()
        case 4:
            self.playAnimationNormal()
        case 5:
            self.playAnimationNormal()
        case 6:
            self.playAnimationNormal()
        case 7:
            self.playAnimationNormal()
        default:
            self.playAnimationNormal()
            
        }
    }
    /**

        Will play the animation looking to multiple places
     
     */
    public func playAnimationLooking(){
        self.removeAllActions()
        if let idleTextures: [SKTexture] = self.texturesContainer?.idleTextures {
            let textures: [SKTexture] = self.texturesSpliterBetween(firstPosition: 0, secondPosition: 5, textures: idleTextures)
            let animation: SKAction = SKAction.animate(with: textures, timePerFrame: 1)
            self.run(animation)
        }

    }
    /**
    
     Will randomize the time the singer stays smiling
     
     */
    public func playAnimationSmile(){
        self.removeAllActions()
        if let textureSmiling: SKTexture = self.texturesContainer?.idleTextures.last{
            if let textureNormal: SKTexture = self.texturesContainer?.idleTextures.first{
                let animation: SKAction = SKAction.run {
                    let goToFirstTexture: SKAction = SKAction.run({
                        self.texture = textureNormal
                    })
                    let firstWaitAction: SKAction = SKAction.wait(forDuration: Double.randomBetween(minValue: 1, maxValue: 10))
                    let goToSecondTexture: SKAction = SKAction.run({
                        self.texture = textureSmiling
                    })
                    let secondWaitAction: SKAction = SKAction.wait(forDuration: Double.randomBetween(minValue: 1, maxValue: 5))
                    
                    let sequence: SKAction = SKAction.sequence([goToFirstTexture,firstWaitAction,goToSecondTexture,secondWaitAction,goToFirstTexture])
                    self.run(sequence)
                }
                self.run(animation)
            }
        }

    }
    /**
     Will change the texture to smiling
     */
    public func justSmile(){
        self.removeAllActions()
        if let textureSmiling: SKTexture = self.texturesContainer?.idleTextures.last{
            self.texture = textureSmiling
        }
    }
    /**
     Will change the texture to idle
     */
    public func playAnimationNormal(){
        self.removeAllActions()
        if let firstTexture: SKTexture = self.texturesContainer?.idleTextures.first{
            self.texture = firstTexture
        }
    }

    /**
     Play animation of singing
     */
    private func playAnimationSinging(){
        if let singingTextures: [SKTexture] = self.texturesContainer?.singingTextures {
            let animation: SKAction = SKAction.animate(with: singingTextures, timePerFrame: 0.128)
            self.run(SKAction.repeatForever(animation))
        }

    }
    
    /**
     
     Randomize the muted animation
     
     */
    private func playAnimationMuted(){
        let randomInt = Int.randomBetween(lowerValue: 0, maxValue: K.Singer.Muted.numberOfSprites)
        switch randomInt {
        case 0:
            self.playAngryMutedAnimation()
        case 1:
            self.playAngryMutedAnimation()
        case 2:
            self.playSadMutedAnimation()
        case 3:
            self.playSadMutedAnimation()
        default:
            self.playSadMutedAnimation()
        }
        
    }
    /**
     Will play the angry animation on the singer
     */
    public func playAngryMutedAnimation(){
        self.removeAllActions()
        if let mutedTextures: [SKTexture] = self.texturesContainer?.mutedTextures {
            let textures: [SKTexture] = self.texturesSpliterBetween(firstPosition: 0, secondPosition: K.Singer.Muted.numberOfSprites/2, textures: mutedTextures)
            let animation: SKAction = SKAction.animate(with: textures, timePerFrame: 1)
            self.run(animation)
        }

    }
    /**
     Will play the muted animation on the singer
     */
    public func playSadMutedAnimation(){
        self.removeAllActions()
        if let mutedTextures: [SKTexture] = self.texturesContainer?.mutedTextures {
            let textures: [SKTexture] = self.texturesSpliterBetween(firstPosition: 2, secondPosition: K.Singer.Muted.numberOfSprites, textures: mutedTextures)
            let animation: SKAction = SKAction.animate(with: textures, timePerFrame: 1)
            self.run(animation)
        }
    }
    
    /// Dont really need it if change to angry - sad  or just sad
    private func texturesSpliterBetween(firstPosition: Int, secondPosition: Int, textures: [SKTexture])-> [SKTexture]{
        return Array(textures[firstPosition...secondPosition])
    }
}

/**

    Extension containg all the Singer + Touches implementation
 
 */
extension Singer {
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch: UITouch = touches.first {
            if let parent: SKNode = self.parent {
                let location: CGPoint = touch.location(in: parent)
                if self.contains(location){
                    self.orderToChange()
                }
            }
        }
    }
}



