//
//  Double+RandomGenerator.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 27/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import Foundation

/**
 This extensions was implemented to help my algorithim with a random double generator
 */
public extension Double {
    
    /**
     Generate a random double between two values
     - parameters:
     - lowerValue: the lower value
     - maxValue: the max value
     - returns: Random Integer between lower and max values
     */
    public static func randomBetween(minValue: Double, maxValue: Double)-> Double{
        return Double(arc4random_uniform( UInt32(maxValue - minValue))  + UInt32(minValue))
    }
}
