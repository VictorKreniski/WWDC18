//
//  FiniteStateMachine+Singer.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 18/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import Foundation

/*
 
 All possible states singer can be
 
 idle - Not singing and paused game
 muted - Muted
 singing - Singing
 
 */
public enum SingerStates {
    
    case idle, muted, singing
    
}

/*
 
 All possible actions singer can execute between states
 
 idleToMuted - Singer clicked while the game is paused
 idleToSinging - Press Play
 mutedToSinging - Singer clicked while the game is playing
 singingToMuted - Singer clicked while the game is playing
 singingToIdle - Press Pause
 mutedToIdle - Singer clicked while the game is paused
 
 */
public enum SingerActions {
    
    case idleToMuted, idleToSinging, mutedToSinging, singingToMuted, singingToIdle, mutedToIdle
    
}

/*
 
 Extension with all Singer and FiniteStateMachine implementation
 
 */
extension Singer {
    
    /*
     
     This method is responsable for setting up the inital state and setting all possible actions
     
     */
    func setupStatesForFiniteStateMachine(){
        
        self.finiteStateMachine = FiniteStateMachine(initialState: .idle)
        self.finiteStateMachine?.addAction(.idleToMuted, from: .idle, to: .muted)
        self.finiteStateMachine?.addAction(.idleToSinging, from: .idle, to: .singing)
        self.finiteStateMachine?.addAction(.mutedToSinging, from: .muted, to: .singing)
        self.finiteStateMachine?.addAction(.singingToMuted, from: .singing, to: .muted)
        self.finiteStateMachine?.addAction(.singingToIdle, from: .singing, to: .idle)
        self.finiteStateMachine?.addAction(.mutedToIdle, from: .muted, to: .idle)
        
    }
    
}
