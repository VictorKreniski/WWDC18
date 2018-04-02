//
//  Int+RandomNumberGenerator.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 27/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import Foundation

/**
 This extension was implemented to help my algorithim with a random int generator
 */
public extension Int {
    
    /**
     Generate a random int between two values
     - parameters:
     - lowerValue: the lower value
     - maxValue: the max value
     - returns: Random Integer between lower and max values
     */
    public static func randomBetween(lowerValue: Int, maxValue: Int)-> Int{
        return Int(arc4random_uniform( UInt32(maxValue - lowerValue))  + UInt32(lowerValue))
    }
}
