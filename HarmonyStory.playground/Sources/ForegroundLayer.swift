//
//  ForegroundLayer.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 26/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit

/*
 
 All logic of foreground will be created and executed here
 
 */
public class ForegroundLayer: SKNode{
    
    /// If the curtain were opened
    private var presentedCurtainAnimation: Bool = false
    
    /// First label in the game
    private var firstLabelNode: TextLabel
    
    /**
     Init of ForegroundLayer
     - parameters:
     - size: size of foreground

     */
    public init(size: CGSize) {
        self.firstLabelNode = TextLabel(text: "Click on the courtain", position: CGPoint(x: size.width/2, y: size.height*0.05), zPosition: 11)
        super.init()
        self.createAndSetupCurtain(size: size, position: CGPoint(x: size.width/2, y: size.height/2.5))
        self.isUserInteractionEnabled = true
        
        self.addChild(self.firstLabelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /**
     This method will create and setup the curtain
     - parameters:
     - size: Curtain Size
     - position: Curtain position in scene
     */
    private func createAndSetupCurtain(size: CGSize, position: CGPoint){
        if let curtainToAnimation: SKTexture = TexturesManager.shared.getTexture(named: K.ForegroundLayer.Curtain.spriteName){
            let curtain: Curtain = Curtain(position: position, rightTexture: curtainToAnimation, size: size)
            curtain.zPosition = 10
            self.addChild(curtain)
        }
        
    }
    
    /**
     This method will aninamte the curtain
     */
    public func callCurtainAnimation(){
        self.enumerateChildNodes(withName: K.ForegroundLayer.Curtain.nodeName) { ( node, error) in
            if node.name == K.ForegroundLayer.Curtain.nodeName {
                if let curtain: Curtain = node as? Curtain{
                    curtain.executeAnimation()
                    self.firstLabelNode.fadeOutTextLabel(animationDuration: 1.5)
                }
            }
        }
    }
    
}

/**
 Here, all implementations of ForegroundLayer + Touches are done
 */
extension ForegroundLayer {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !presentedCurtainAnimation{
            self.callCurtainAnimation()
            self.isUserInteractionEnabled = false
            self.presentedCurtainAnimation = true
            if let gameScene: GameScene = self.parent as? GameScene{
                gameScene.startStory()
            }
        }
    }
}
