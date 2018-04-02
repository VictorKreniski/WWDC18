//
//  BackgroundLayer.swift
//  KreviHarmony
//
//  Created by Victor Oliveira Kreniski on 15/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit


/*
 
 All logic of background will be created and executed here
 
 */
public class BackgroundLayer: SKNode{
    
    /**
     Init of backgroundLayer
     - parameters:
     - size: size of background
     */
    public init(size: CGSize) {
        super.init()
        self.createAndSetupStage(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     This method is responsable for creating and setup the stage in the backgroundLayer Node
     - parameters:
     - size: size of the stage
     */
    private func createAndSetupStage(size: CGSize){
        if let texture: SKTexture  = TexturesManager.shared.getTexture(named: K.BackgroundLayer.FullStage.stageSpriteName){
            let stage: SKSpriteNode = SKSpriteNode(texture: texture)
            stage.position = CGPoint(x: size.width/2, y: size.height/2)
            stage.size = size
            stage.name = K.BackgroundLayer.FullStage.nodeName
            self.addChild(stage)
        }
    }
}

