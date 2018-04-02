//
//  TexturesSingleton.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 20/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit
import Foundation


/**
 This class is responsable for holding all the textures in the game
 Its a good practice to allocate all the textures together
 This class be reused without being allocated again while the game still running.
 */
public final class TexturesManager{
    
    /// Shared instance to textures manager will all textures stored
    static let shared: TexturesManager = TexturesManager()
    
    /// Variable with a dictionary of String: Texture with all textures referenced by a String
    private var textures: [String: SKTexture] = [String: SKTexture]()
    
    /**
     This method will add a texture to the dictionary
     - parameters:
     - texture: The texture it self
     - named: The name to search in the dictionary
     */
    public func add(texture: SKTexture, named: String){
        if self.textures[named] == nil {
            self.textures[named] = texture
        }
    }
    
    /**
     This method will return, if exists, a SKTexture based on the named parameter
     - parameters:
     - named: The name to search in the dictionary
     - returns: SKTexture
     */    public func getTexture(named: String)->SKTexture?{
        return self.textures[named]
    }
    
    /**
     This method will return, if exists, a array of SKTextures, based on the named paramater, lowerValue and upperValue.
     Example of name this method will search: sprite2
     - parameters:
     - named: The base name of all sprites
     - lowerValue: the lowest value the loop will start, looking for textures
     - upperValue: the upper value the loop will reach, looking for textures
     - returns: An array of SKTexture
     */    public func getTextures(named: String,lowerValue: Int, upperValue: Int) -> [SKTexture]?{
        var textures: [SKTexture] = [SKTexture]()
        for index in lowerValue...upperValue {
            if let texture: SKTexture = self.getTexture(named: named+"\(index)"){
                textures.append(texture)
            }
        }
        return textures
    }
    
    /**
     This method will load multiple SKTextures into the TexturesManager
     - parameters:
     - max: The max value to loop
     - named: The base name to search textures
     */
    private func loadSprites(max: Int,named: String){
        for index in 0...max{
            let texture: SKTexture = SKTexture(imageNamed: named + "\(index)")
            self.add(texture: texture, named: named + "\(index)")
        }
    }
    
    /**
     This init will instatiate all the textures for the game
     
     - important: It will load everything on the memory in the first time the shared variable is called
     
     */
    private init(){
        
        self.add(texture: SKTexture(imageNamed: K.GameLayer.ButtonPlayPause.playSpriteName), named: K.GameLayer.ButtonPlayPause.playSpriteName)
        self.add(texture: SKTexture(imageNamed: K.GameLayer.ButtonPlayPause.pauseSpriteName), named: K.GameLayer.ButtonPlayPause.pauseSpriteName)
        
        self.add(texture: SKTexture(imageNamed: K.BackgroundLayer.FullStage.stageSpriteName), named: K.BackgroundLayer.FullStage.stageSpriteName)
        self.add(texture: SKTexture(imageNamed: K.ForegroundLayer.Curtain.spriteName), named: K.ForegroundLayer.Curtain.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Red.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Red.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Red.name + K.Singer.Muted.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Blue.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Blue.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Blue.name + K.Singer.Muted.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Green.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Green.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Green.name + K.Singer.Muted.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Yellow.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Yellow.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Yellow.name + K.Singer.Muted.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Purple.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Purple.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Purple.name + K.Singer.Muted.spriteName)
        
        self.loadSprites(max: K.Singer.Singing.numberOfSprites, named: K.Singer.Orange.name + K.Singer.Singing.spriteName)
        self.loadSprites(max: K.Singer.Idle.numberOfSprites, named: K.Singer.Orange.name + K.Singer.Idle.spriteName)
        self.loadSprites(max: K.Singer.Muted.numberOfSprites, named: K.Singer.Orange.name + K.Singer.Muted.spriteName)
    }
}
/**
 This struct is a representation of a container to hold all the three states of animations
 */
public struct SingerTexturesContainer{
    
    /// All textures to create singing animation
    public var singingTextures: [SKTexture] = [SKTexture]()
    /// All textures to create idle animation
    public var idleTextures: [SKTexture] = [SKTexture]()
    /// All textures to create muted animation
    public var mutedTextures: [SKTexture] = [SKTexture]()
    
    /**
     Init to setup the SingerTexturesContainer
     */
    public init(singing: [SKTexture],idle: [SKTexture], muted: [SKTexture]){
        self.singingTextures = singing
        self.idleTextures = idle
        self.mutedTextures = muted
    }
    
}
/**
 This class is responsable for managing the SingerTexturesContainer based on a Name
    it will return a container with all textures based on a colour string
 Example: if blue, it will return a container with all textures of blue color.
 */
public final class SingerTextureContainerManager{
    
    /**
     This method will search in the Textures Manager all the textures relative to one specif color
     - parameters:
     - named: Singer color
     - returns: SingerTexturesContainer relative to the color
     */
    public static func getContainerByColour(named: String)-> SingerTexturesContainer? {
        let lowestSpriteNumber: Int = K.lowerSpriteNumber
        if let idleTextures: [SKTexture] = TexturesManager.shared.getTextures(named: named + K.Singer.Idle.spriteName, lowerValue: lowestSpriteNumber
            , upperValue: K.Singer.Idle.numberOfSprites){
            if let singingTextures: [SKTexture] = TexturesManager.shared.getTextures(named: named + K.Singer.Singing.spriteName, lowerValue: lowestSpriteNumber, upperValue: K.Singer.Singing.numberOfSprites){
                if let mutedTextures: [SKTexture] = TexturesManager.shared.getTextures(named: named + K.Singer.Muted.spriteName, lowerValue: lowestSpriteNumber, upperValue: K.Singer.Muted.numberOfSprites){
                    return SingerTexturesContainer(singing: singingTextures, idle: idleTextures, muted: mutedTextures)
                }
            }
        }
        return nil
    }
    
}




