//
//  GameObject.swift
//  KreviHarmony
//
//  Created by Victor Oliveira Kreniski on 15/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit

/**

 GameObject subclass SKSpriteNode
 
 
 */
public class GameObject: SKSpriteNode{
    
    /**
     Init a instance of gameObject
     - parameters:
     - position: position in scene
     - texture: texture of the SKSSpriteNode
     - size: Size of the ndoe
     */
    public init(position: CGPoint, texture: SKTexture, size: CGSize){
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
