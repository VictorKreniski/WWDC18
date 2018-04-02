//
//  GameLayer.swift
//  KreviHarmony
//
//  Created by Victor Oliveira Kreniski on 15/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit
import AVFoundation

/*
 
 GameLayer is the class responsable for controlling the game itself, here, all things related to the game experience will happen
 
 */
public final class GameLayer: SKNode{
    
    /// My Button to play and pause the singers
    public var playOrStopMusic: Button?
    /// My variable to help my math of sizing the things in this node
    private var sceneInPercentage: SceneInPercentage
    /// singers count
    public var singersInScene: Int = 0
    /// size of game layer because SKNode does not have size
    private let size: CGSize
    /// textLabel
    public var textLabel: TextLabel
    
    /**
     
     Init of GameLayer
     - parameters:
     - size: size

     */
    public init(size: CGSize) {
        self.size = size
        self.sceneInPercentage = SceneInPercentage(height: size.height, width: size.width)
        self.textLabel = TextLabel(text: nil, position: CGPoint(x: size.width/2, y: size.height * 0.05), zPosition: 12)
        super.init()
        self.createPlayerOrStopMusicButton(position: CGPoint(x: size.width/2, y: size.height * 0.1), size: CGSize(width: size.width*0.09, height: size.height*0.09))
        self.playOrStopMusic?.isHidden = true
        self.addChild(textLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     tu 
     This method will setup and add on scene a button
     - parameters:
     - position: Position in scene
     - size: Size of the button
     
     */
    private func createPlayerOrStopMusicButton(position: CGPoint, size: CGSize){
        if let textureDefault: SKTexture = TexturesManager.shared.getTexture(named: K.GameLayer.ButtonPlayPause.playSpriteName){
            if let textureTapped: SKTexture = TexturesManager.shared.getTexture(named: K.GameLayer.ButtonPlayPause.pauseSpriteName){
                self.playOrStopMusic = Button(color: UIColor.clear, position: position, size: size, textureTapped: textureTapped, textureDefault: textureDefault, actionDefault: {
                    self.orderToSing()
                }, actionTapped: {
                    self.orderToStop()
                })
                self.playOrStopMusic?.zPosition = 10
                self.addChild(self.playOrStopMusic!)
            }
        }
    }
    
    /**
     
     This method will increment one singer to the scene
     - parameters:
     - size: Size of the singer to be created
     
     */
    public func incrementSingers(size: CGSize){
        if self.singersInScene < K.GameLayer.CharactersSetup.total{
            let finalPosition: CGPoint = self.setupPositionSinger(of: self.singersInScene)
            let initialPosition: CGPoint = CGPoint(x: finalPosition.x, y: size.height * 1.2)
            let singer: Singer = Singer(position: initialPosition,size: self.setupSizeSinger(of: self.singersInScene), sound: K.GameLayer.sounds[self.singersInScene])
            self.addChild(singer)
            singer.run(SKAction.moveTo(y: finalPosition.y, duration: 0.25))
            self.singersInScene += 1
            
        }
        
    }
    /**
     
     Here based on a logic to populate the 3 rows in stage. I calculate the gap, xPosition and yPosition to each singer
     Most of the values are constants and they are in the Struct K. If you need to make any change, you can change the values in there.
     - parameters:
     - index: index of singers in scene
     
     */
    private func setupPositionSinger(of index: Int)-> CGPoint{
        switch index {
            
        case 0 ..< K.GameLayer.CharactersSetup.FirstRow.count:
            
            return Helper.CalculateCGPoint(heightPercentValue: self.sceneInPercentage.heightPercentage, widthPercentValue: self.sceneInPercentage.widthPercentage, xGapMultiplier: K.GameLayer.CharactersSetup.FirstRow.gap, yMultiplier: K.GameLayer.CharactersSetup.FirstRow.yMultiplier, xMultiplier: K.GameLayer.CharactersSetup.FirstRow.xMultiplier, index: CGFloat(index))
            
        case K.GameLayer.CharactersSetup.FirstRow.count ..< K.GameLayer.CharactersSetup.FirstRow.count + K.GameLayer.CharactersSetup.SecondRow.count:
            
            let suportIndex: Int = K.GameLayer.CharactersSetup.FirstRow.count + K.GameLayer.CharactersSetup.SecondRow.count - index
            
            return Helper.CalculateCGPoint(heightPercentValue: self.sceneInPercentage.heightPercentage, widthPercentValue: self.sceneInPercentage.widthPercentage, xGapMultiplier: K.GameLayer.CharactersSetup.SecondRow.gap, yMultiplier: K.GameLayer.CharactersSetup.SecondRow.yMultiplier, xMultiplier: K.GameLayer.CharactersSetup.SecondRow.xMultiplier, index: CGFloat(suportIndex))
            
        case K.GameLayer.CharactersSetup.SecondRow.count + K.GameLayer.CharactersSetup.FirstRow.count ..< K.GameLayer.CharactersSetup.ThirdRow.count + K.GameLayer.CharactersSetup.FirstRow.count + K.GameLayer.CharactersSetup.SecondRow.count:
            
            let suportIndex: Int = K.GameLayer.CharactersSetup.FirstRow.count + K.GameLayer.CharactersSetup.SecondRow.count + K.GameLayer.CharactersSetup.ThirdRow.count - index
            
            return Helper.CalculateCGPoint(heightPercentValue: self.sceneInPercentage.heightPercentage, widthPercentValue: self.sceneInPercentage.widthPercentage, xGapMultiplier: K.GameLayer.CharactersSetup.ThirdRow.gap, yMultiplier: K.GameLayer.CharactersSetup.ThirdRow.yMultiplier, xMultiplier: K.GameLayer.CharactersSetup.ThirdRow.xMultiplier, index: CGFloat(suportIndex))
            
        default:
            return CGPoint()
        }
    }
    
    /**
     
     This method is responsable for calculate the size i want for each Singer
     
     I am receiving index because if i need to calculate size based on how many characters i have on scene, it will make it easy to create a logic.
     
     */
    private func setupSizeSinger(of index: Int)-> CGSize{
        return Helper.CalculateCGSize(heightPercentValue: self.sceneInPercentage.heightPercentage, widthPercentValue: sceneInPercentage.widthPercentage, yMultiplier: K.GameLayer.CharactersSetup.ySizeMultiplier, xMultiplier: K.GameLayer.CharactersSetup.xSizeMultiplier)
    }
    
    /**
     
     This method is responsable for ordering all singers to sing
     
     */
    public func orderToSing(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        let delayTime: TimeInterval = 0.4
        if singers.count > 0 {
            if let deviceCurrentTime: TimeInterval = singers[0].audioPlayer?.deviceCurrentTime {
                for singer in singers {
                    singer.sing(currentTime: deviceCurrentTime, delay: delayTime)
                }
            }
        }
        
    }
    /**
     
     This method is responsable for stoping every singer of singing
     
     */
    public func orderToStop(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for index in singers {
            index.stopSinging()
        }
    }
    /**
     
     This method will get all singers sad
     
     */
    public func getAllSingersSad(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            singer.playSadMutedAnimation()
        }
    }
    
    /**

     This method will get all singers idle
     
     */
    public func getAllSingersNormal(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            singer.playAnimationNormal()
        }
    }
    
    /**

     This method will get all singers happy
     
     */
    public func getAllSingersHappy(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            singer.justSmile()
        }
    }
    /**
     
     This method will get all singers Muted
     
     */
    public func getAllSingersMuted(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            singer.orderToChange()
        }
    }
    /**
     
     This method will get all the singers volume decreased
     
     */
    public func getAllSingersVolumeDecreased(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            if let volume = singer.audioPlayer?.volume{
                singer.audioPlayer?.volume = volume/3
            }
        }
    }
    /**
     
     This method will increase all the singers volume
     
     */
    public func getAllSingersVolumeIncreased(){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            if let volume = singer.audioPlayer?.volume{
                singer.audioPlayer?.volume = volume*3
            }
        }
    }
    /**
     
    Search if all singers are unmuted
     
     - returns: Bool - True if all are unmuted / False if someone still muted
    
     */
    public func areAllSingersSinging()-> Bool{
        var unmuted: Bool = false
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            if singer.finiteStateMachine?.currentState == SingerStates.singing {
                unmuted = true
            }else{
                return false
            }
        }
        return unmuted
    }
    /*
     
     This method is responsable for searching every Singer in gameLayer
     
     */
    private func findAllSingers(named: String) -> [Singer] {
        var singers: [Singer] = [Singer]()
        self.enumerateChildNodes(withName: named) { (node, stop) in
            if node.name == named {
                if let singer: Singer = node as? Singer{
                    singers.append(singer)
                }
            }
        }
        return singers
    }
    
    /**
     
     This method is responsable for calling all singers touche

     - parameters:
     - touches: Set of touches
     - event: An object that describes a single user interaction with your app.
     
     */
    private func sendTouchToAllSingers(touches: Set<UITouch>, event: UIEvent?){
        let singers: [Singer] = self.findAllSingers(named: K.Singer.nodeName)
        for singer in singers {
            singer.touchesBegan(touches, with: event)
        }
    }


}
/**
 
 This extension GameLayer + Touches

 */
extension GameLayer{
    
    /**
     
     This method will setup and add on scene a button
     - parameters:
     - position: Position in scene
     - size: Size of the button
     
     */
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.sendTouchToAllSingers(touches: touches, event: event)
    }
}

