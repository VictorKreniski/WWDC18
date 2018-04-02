//
//  TextLabel.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 29/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit

/**
This class is responsable for creating a pattern of label to the game
 */
public final class TextLabel: SKLabelNode{
    
    /**
     This method will init a instance of TextLabel
     - parameters:
     - text: Optional text to be presented on TextLabel
     - position: The position is going to be localized
     - zPosition: The zPosition is going to be
     */
    public init(text: String?, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.fontSize = 33
        if let initialText: String = text {
            self.text = initialText
        }
        self.zPosition = zPosition
        self.position = position
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    This method fadeOut the TextLabel
     - parameters:
     - animationDuration: The time the animation will have to be done
     */
    public func fadeOutTextLabel(animationDuration: TimeInterval){
        self.run(SKAction.fadeOut(withDuration: animationDuration))
    }
    /**
     This method fadeIn the TextLabel
     - parameters:
     - animationDuration: The time the animation will have to be done
     */
    public func fadeInTextLabel(animationDuration: TimeInterval){
        self.run(SKAction.fadeIn(withDuration: animationDuration))
    }
    /**
     This method will remove from parent with a animation of fading out
     - parameters:
     - animationDuration: The time the animation will have to be done.
     */
    public func removeFromParent(animationDuration: TimeInterval) {
        self.fadeOutTextLabel(animationDuration: animationDuration)
        self.run(SKAction.wait(forDuration: animationDuration)) {
            self.removeFromParent()
        }
    }
}
