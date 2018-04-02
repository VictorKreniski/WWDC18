//
//  Helper.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 22/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit

/**
 This class is responsable for helping
 */
public final class Helper{
    
    /**
     Private is init because i don't want any instance of this class in the program
     */
    private init(){}
    
    /**
     Calculate a CGPoint based on parameters
     - parameters:
     - heightPercentValue: Height value equivalent to 1%
     - widthPercentValue: Width value equivalent to 1%
     - xGapMuliplier: The gap between different index
     - yMultiplier: y axis multiplier
     - xMultiplier: x axis multiplier
     - index: index
     - returns: CGPoint
     */
    public static func CalculateCGPoint(heightPercentValue: CGFloat,
                                        widthPercentValue: CGFloat,
                                        xGapMultiplier: CGFloat,
                                        yMultiplier: CGFloat,
                                        xMultiplier: CGFloat,
                                        index: CGFloat) -> CGPoint{
        
        let xGapValue: CGFloat = widthPercentValue * xGapMultiplier
        let yValue: CGFloat = heightPercentValue * yMultiplier
        let xValue: CGFloat = ( widthPercentValue * xMultiplier ) + ( xGapValue * index )
        return CGPoint(x: xValue, y: yValue)
    }

    /**
     Calculate a Size based on parameters
     - parameters:
     - heightPercentValue: Height value equivalent to 1%
     - widthPercentvalue: Width value equivalent to 1%
     - yMultiplier: y axis multiplier
     - xMultiplier: x axis multiplier
     - returns: CGSize
     */
    public static func CalculateCGSize(heightPercentValue: CGFloat,
                                       widthPercentValue: CGFloat,
                                       yMultiplier: CGFloat,
                                       xMultiplier: CGFloat)-> CGSize{
        return CGSize(width: widthPercentValue*xMultiplier, height: heightPercentValue*yMultiplier)
    }
}

/**

 A class that holds values in percentage

 */
public final class SceneInPercentage{
    
    init(height: CGFloat, width: CGFloat) {
        self.heightPercentage = 1
        self.widthPercentage = 1
        defer { self.heightPercentage = height }
        defer { self.widthPercentage = width }
    }
    /// Denominator of the height and width
    public var denominator: CGFloat = 100{
        didSet {
            if self.denominator == 0 {
                self.denominator = 1
            }
        }
    }
    /// Height in percentage
    public var heightPercentage: CGFloat{
        didSet {
            self.heightPercentage /= self.denominator
        }
    }
    //// Width in percentage
    public var widthPercentage: CGFloat{
        didSet{
            self.widthPercentage /= self.denominator
        }
    }
}
