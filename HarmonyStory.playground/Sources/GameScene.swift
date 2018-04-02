//
//  GameScene.swift
//  KreviHarmony
//
//  Created by Victor Oliveira Kreniski on 15/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit
import AVFoundation


/**
 This class is going to have control over every node in the game
 */
public class GameScene: SKScene{
    
    /// GameLayer
    private let gameLayer: GameLayer?
    /// BackgroundLayer
    private let backgroundLayer: BackgroundLayer?
    /// ForegroundLayer
    private let foregroundLayer: ForegroundLayer?
    
    /// Voice over
    private let voiceOver: AVSpeechManager?
    
    /// Stage of my cutscene to tell the story
    private var storyStage: Int = 0 {
        didSet{
            self.advanceStory()
        }
    }
    /// Bool if the cutscene is happening
    private var cutsceneHappening: Bool = false
    /**
     Init of gameScene
     - parameters:
     - size: size of the gameScene
     */
    public override init(size: CGSize) {
        self.voiceOver = AVSpeechManager(text: "I'm going to tell you a story")
        self.backgroundLayer = BackgroundLayer(size: size)
        self.backgroundLayer?.zPosition = 0
        self.gameLayer = GameLayer(size: size)
        self.gameLayer?.zPosition = 1
        self.foregroundLayer = ForegroundLayer(size: size)
        self.foregroundLayer?.zPosition = 2
        super.init(size: size)
        self.voiceOver?.aVSpeechManagerDelegate = self
        self.isUserInteractionEnabled = false
        self.addChild(self.backgroundLayer!)
        self.addChild(self.gameLayer!)
        self.addChild(self.foregroundLayer!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Called to start the cutscene order
     */
    public func startStory(){
        self.voiceOver?.readText()
    }
    
    /**
     Have all the logic to make my cutscene happens
     */
    public func advanceStory(){
        switch self.storyStage {
        case 1:
            self.cutsceneHappening = true
            self.talkAndShowThis(text: "Once upon a time")
        case 2:
            self.gameLayer?.incrementSingers(size: self.size)
            self.talkAndShowThis(text: "A sound came on stage")
        case 3:
            self.talkAndShowThis(text: "And started to perform his sound")
        case 4:
            self.gameLayer?.orderToSing()
            self.run(SKAction.wait(forDuration: 6.5), completion: {
                self.gameLayer?.orderToStop()
                self.talkAndShowThis(text: "He was a lonely sound")
            })
        case 5:
            self.gameLayer?.getAllSingersSad()
            self.talkAndShowThis(text: "And he felt sad...")
        case 6:
            self.run(SKAction.wait(forDuration: 0.5), completion: {
                self.talkAndShowThis(text: "Then, one day")
            })
        case 7:
            self.gameLayer?.incrementSingers(size: self.size)
            self.talkAndShowThis(text: "He found another sound")
            
        case 8:
            self.gameLayer?.getAllSingersNormal()
            self.talkAndShowThis(text: "And they thought")
        case 9:
            self.talkAndShowThis(text: "Together")
        case 10:
            self.talkAndShowThis(text: "We can do more")
        case 11:
            self.gameLayer?.orderToSing()
            self.run(SKAction.wait(forDuration: 8), completion: {
                self.gameLayer?.orderToStop()
                self.run(SKAction.wait(forDuration: 0.5), completion: {
                    self.talkAndShowThis(text: "And because of that")
                })
            })
        case 12:
            self.gameLayer?.getAllSingersHappy()
            self.talkAndShowThis(text: "They noticed")
        case 13:
            self.talkAndShowThis(text: "With others")
        case 14:
            self.talkAndShowThis(text: "They could create harmony")
        case 15:
            self.talkAndShowThis(text: "To do so")
        case 16:
            self.talkAndShowThis(text: "They invited other sounds")
        case 17:
            let actionBlock: SKAction = SKAction.run {
                self.gameLayer?.incrementSingers(size: self.size)
            }
            let wait: SKAction = SKAction.wait(forDuration: 0.5)
            let sequence: SKAction = SKAction.sequence([actionBlock,wait])
            self.run(SKAction.repeat(sequence, count: K.GameLayer.CharactersSetup.total - 9), completion: {
                self.gameLayer?.orderToSing()
                self.gameLayer?.getAllSingersMuted()
                self.storyStage += 1
            })
        case 18:
            self.talkAndShowThis(text: "Now, help them create harmony")
        case 19:
            self.talkAndShowThis(text: "Click on each one of them to unmute")
        case 20:
            self.talkAndShowThis(text: "And see what cooperation united to diversity")
        case 21:
            self.talkAndShowThis(text: "Are capable of")
        case 22:
            self.gameLayer?.textLabel.fadeOutTextLabel(animationDuration: 0.25)
            self.gameLayer?.textLabel.text = ""
            self.isUserInteractionEnabled = true
        case 23:
            self.isUserInteractionEnabled = false
            self.run(SKAction.wait(forDuration: 10)) {
                self.gameLayer?.orderToStop()
                self.gameLayer?.textLabel.fadeInTextLabel(animationDuration: 0)
                self.talkAndShowThis(text: "Now")
            }
        case 24:
            self.talkAndShowThis(text: "They know")
        case 25:
            self.talkAndShowThis(text: "Diversity and Cooperation")
        case 26:
            self.talkAndShowThis(text: "Blended together")
        case 27:
            self.talkAndShowThis(text: "Means harmony")
        case 28:
            self.talkAndShowThis(text: "So")
        case 29:
            self.talkAndShowThis(text: "More we have")
        case 30:
            self.run(SKAction.wait(forDuration: 0.15), completion: {
                self.talkAndShowThis(text: "Far we go")
            })
        case 31:
            let actionBlock: SKAction = SKAction.run{
                self.gameLayer?.incrementSingers(size: self.size)
            }
            let wait: SKAction = SKAction.wait(forDuration: 0.25)
            let sequence: SKAction = SKAction.sequence([actionBlock,wait])
            self.run(SKAction.repeat(sequence, count: K.GameLayer.CharactersSetup.total - 6), completion: {
                self.storyStage += 1
            })
        case 32:
            let wait: SKAction = SKAction.wait(forDuration: 1)
            let actionBlock: SKAction = SKAction.run {
                self.gameLayer?.orderToSing()
                self.gameLayer?.getAllSingersMuted()
            }
            self.run(SKAction.sequence([wait,actionBlock])) {
                self.talkAndShowThis(text: "Let's do it again")
            }
        case 33:
            self.talkAndShowThis(text: "Unmute them")
        case 34:
            self.isUserInteractionEnabled = true
            self.gameLayer?.textLabel.fadeOutTextLabel(animationDuration: 0.25)
            self.gameLayer?.textLabel.text = ""
        case 35:
            self.isUserInteractionEnabled = false
            let wait: SKAction = SKAction.wait(forDuration: 15)
            let changeVolume: SKAction = SKAction.run {
                self.gameLayer?.getAllSingersVolumeDecreased()
            }
            let waitAgain: SKAction = SKAction.wait(forDuration: 0.5)
            let sequence: SKAction = SKAction.sequence([wait,changeVolume,waitAgain])
            self.run(sequence, completion: {
                self.gameLayer?.textLabel.fadeInTextLabel(animationDuration: 0)
                self.talkAndShowThis(text: "We all need each other!")
            })
        case 36:
            self.run(SKAction.wait(forDuration: 1), completion: {
                self.talkAndShowThis(text: "WWDC 2018")
            })
        case 37:
            self.talkAndShowThis(text: "Conducts harmony")
        case 38:
            self.talkAndShowThis(text: "Bringing developers")
        case 39:
            self.talkAndShowThis(text: "From all over the world")
        case 40:
            self.talkAndShowThis(text: "Into the same stage")
        case 41:
            self.run(SKAction.wait(forDuration: 3), completion: {
                self.talkAndShowThis(text: "Now, interact with every sound in the scene")
            })
        case 42:
            self.talkAndShowThis(text: "Have fun!")
        case 43:
            self.gameLayer?.textLabel.removeFromParent(animationDuration: 1)
            self.run(SKAction.wait(forDuration: 1), completion: {
                self.gameLayer?.getAllSingersVolumeIncreased()
                self.isUserInteractionEnabled = true
                self.gameLayer?.playOrStopMusic?.selected = true
                self.gameLayer?.playOrStopMusic?.isHidden = false
                self.gameLayer?.playOrStopMusic?.animateHighlight()
            })
        default:
            print("Failed to tell the story")
        }
    }
    
    /**
     Change the text the label and the voice over will present
     - parameters:
     - text: The text to be showed on label and read by voice over
     */
    private func talkAndShowThis(text: String){
        let text: String = text
        self.gameLayer?.textLabel.text = text
        self.voiceOver?.changeUtterance(text: text)
        self.voiceOver?.readText()
    }
    
}

/**
 
 Here, all the GameScene + AVSpeechManagerDelegate Protocol implementation is done
 
 */
extension GameScene: AVSpeechManagerDelegate{
    public func speakerDidFinished() {
        self.storyStage += 1
    }
}
extension GameScene{
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.gameLayer?.touchesBegan(touches, with: event)
        if self.cutsceneHappening {
            if self.gameLayer?.areAllSingersSinging() ?? false {
                if self.storyStage == 22 {
                    self.storyStage += 1
                } else if self.storyStage == 34 {
                    self.storyStage += 1
                }
                
            }
        }
    }
}

