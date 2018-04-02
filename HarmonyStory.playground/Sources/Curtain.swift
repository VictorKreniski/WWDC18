//
//  Curtain.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 28/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit


/**

 This class is a subclass of SKNode and represent a curtain object in scene
 
 */
public class Curtain: SKNode{
    
    private var leftCurtain: GameObject
    private var rightCurtain: GameObject
    
    /**
    Init of Curtain
     - parameters:
     - position: Sound representation
     - rightTexture: the texture it will be placed on the right side
     - size: size of this node
     */
    public init(position: CGPoint, rightTexture: SKTexture, size: CGSize) {
        
        self.rightCurtain = GameObject(position: CGPoint(x: position.x * 1.20, y: position.y*1.25), texture: rightTexture, size: size)
        self.leftCurtain = GameObject(position: CGPoint(x: position.x * 0.80, y: position.y*1.25), texture: rightTexture, size: size)
        
        super.init()
        self.name = K.ForegroundLayer.Curtain.nodeName
        self.leftCurtain.xScale = self.leftCurtain.xScale * -1
        self.addChild(self.leftCurtain)
        self.addChild(self.rightCurtain)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     
     This method will execute the curtain opening animation

     */
    public func executeAnimation(){
        let movement: CGFloat = self.leftCurtain.position.x * 0.05
        let actionBlock: SKAction = SKAction.run {
            self.leftCurtain.position.x -= movement
            self.rightCurtain.position.x += movement
        }
        let wait: SKAction = SKAction.wait(forDuration: 0.1)
        let sequence: SKAction = SKAction.sequence([actionBlock,wait])
        let repeatAction: SKAction = SKAction.repeat(sequence, count: 17)
        self.run(repeatAction) {
            self.removeFromParent()
        }
    }
    
}
