//
//  Button.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 19/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit

/**
 
 This class is responsable for creating a button style as a subclass of SKSpriteNode
 
 */
public final class Button: SKSpriteNode{
    
    // MARK: - Properties
    /// will contain the texture in the button for default state
    private var textureDefault: SKTexture
    /// will contain the texture in the button for pressed state
    private var textureTapped: SKTexture
    /// its a state containg true or false as the button is pressed or not
    public var selected: Bool = false{
        didSet{
            if selected{
                self.texture = textureTapped
            }else{
                self.texture = textureDefault
            }
        }
    }
    /// is a block property that will contain the code to be executed as the main function in the button
    private var actionDefault: () -> Void
    /// is a block property that will contain the code to be executed as the button is clicked and change to first state
    private var actionTapped: () -> Void
    /// the alphaValue when the button is pressed
    private let alphaValuePressed: CGFloat = 0.8
    /// the alphaValue when the button is released
    private let alphaValueRelease: CGFloat = 1
    /// normal size based on the first size at init parameters
    private let normalSize: CGSize
    /// id of the hightlight action
    private let hightlightAnimationIdentifier: String = "HighlightAnimationIdentifier"
    /// animated default value
    private var animated: Bool = false
    // MARK: init
    
    /**
     Init of button instance
     - parameters:
     - color: color of the button
     - position: position in scene
     - size: size of the button
     - textureTapped: texture when the button is tapped
     - textureDefault: texture when the button is in default
     - actionDefault: block of code to be executed when the default button is clicked
     - actionTapped: block of code to be executed when the tapped button is clicked
     */
    public init(color: UIColor,position: CGPoint ,size: CGSize, textureTapped: SKTexture, textureDefault: SKTexture, actionDefault: @escaping () -> Void, actionTapped: @escaping()-> Void) {
        
        let proportion: CGSize
        if size.height > size.width {
            proportion = CGSize(width: size.height, height: size.height)
        }else{
            proportion = CGSize(width: size.width, height: size.width)
        }
        self.normalSize = proportion
        self.textureTapped = textureTapped
        self.textureDefault = textureDefault
        self.actionDefault = actionDefault
        self.actionTapped = actionTapped
        super.init(texture: textureDefault, color: color, size: proportion)
        self.position = position
        self.isUserInteractionEnabled = true
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Creates an highlight animation to atract attention from the user
     */
    public func animateHighlight(){
        let increaseMultiplier: CGFloat = 1.05
        let decreaseMultiplier: CGFloat = 0.95
        let increaseScale: SKAction = SKAction.scale(to: CGSize(width: self.normalSize.width*increaseMultiplier, height: self.normalSize.height*increaseMultiplier), duration: 0.4)
        let decreaseScale: SKAction = SKAction.scale(to: CGSize(width: self.normalSize.width*decreaseMultiplier, height: self.normalSize.height*decreaseMultiplier), duration: 0.4)
        let sequence: SKAction = SKAction.sequence([increaseScale,decreaseScale])
        let repeate: SKAction = SKAction.repeatForever(sequence)
        self.run(repeate, withKey: hightlightAnimationIdentifier)
        self.animated = true
    }
    /**
     Cancel the highlight effect
     */
    private func cancelHighlight(){
        self.animated = false
        self.removeAction(forKey: self.hightlightAnimationIdentifier)
    }
    
    /**
     Decrease the button scale
     */
    private func decreaseScale(){
        let decreaseMultiplier: CGFloat = 0.95
        let duration: TimeInterval = 0.1
        self.run(SKAction.scale(to: CGSize(width: self.normalSize.width*decreaseMultiplier, height: self.normalSize.height*decreaseMultiplier), duration: duration))
    }
    /**
     Increase the button scale
     */
    private func increaseScale(){
        let duration: TimeInterval = 0.1
        self.run(SKAction.scale(to: self.normalSize, duration: duration))
    }
}

/**
 This extension contains all the button + touches implementation
 */
extension Button {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch: UITouch = touches.first {
            if let parent: SKNode = self.parent {
                let location: CGPoint = touch.location(in: parent)
                if self.contains(location){
                    self.alpha = self.alphaValuePressed
                    self.decreaseScale()
                    if self.animated {
                        self.cancelHighlight()
                    }
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch: UITouch = touches.first {
            if let parent: SKNode = self.parent {
                let location: CGPoint = touch.location(in: parent)
                if self.contains(location){
                    if !self.selected {
                        self.actionDefault()
                    } else {
                        self.actionTapped()
                    }
                    self.increaseScale()
                    self.selected = !self.selected
                    self.alpha = self.alphaValueRelease
                }
            }
            
        }
    }
}
