//
//  Constant.swift
//  HarmonyKrevi
//
//  Created by Victor Oliveira Kreniski on 16/03/18.
//  Copyright © 2018 Victor Oliveira Kreniski. All rights reserved.
//

import SpriteKit


/**
    K is a struct to hold all the constants in my game
    This struct make it easy to change values for the entire game
 
    K stands for Constants
 */
public struct K {
    
    /// The base value of all sprites in game. Example: Sprite0
    public static let lowerSpriteNumber: Int = 0
    
    /// All the singer config and constant data
    public struct Singer {
        
        //// NodeName used to find all the singers
        public static let nodeName: String = "Singer"
        
        /// Muted config
        public struct Muted {
            
            /// SpriteName to search muted sprites
            public static let spriteName: String = "Muted"//+Index
            
            /// How many muted sprites
            public static let numberOfSprites: Int = 3//Counting from 0
            
            private init(){}
        }
        /// Idle config
        public struct Idle {
            
            /// SpriteName to search idle sprites
            public static let spriteName: String = "Idle"//+Index
            
            /// How many idle sprites
            public static let numberOfSprites: Int = 6 // Counting from 0
            
            private init(){}
        }
        //// Singing config
        public struct Singing {
            
            /// SpriteName to search singing sprites
            public static let spriteName: String = "Singing"//+Index
            
            /// How many singing sprites
            public static let numberOfSprites: Int = 24 // Counting from 0
            
            private init(){}
        }
        
        /// Blue singer config
        public struct Blue{
            public static let name: String = "Blue"
            
            private init(){}
        }
        
        /// Green singer config
        public struct Green {
            public static let name: String = "Green"
            
            private init(){}
        }
        
        /// Red singer config
        public struct Red {
            public static let name: String = "Red"
            
            private init(){}
        }
        
        
        /// Yellow singer config
        public struct Yellow{
            public static let name: String = "Yellow"
            
            private init(){}
        }
        
        /// Orange singer config
        public struct Orange{
            public static let name: String = "Orange"
            
            private init(){}
        }
        
        
        /// Purple singer config
        public struct Purple{
            public static let name: String = "Purple"
            
            private init(){}
        }
        
        private init(){}
    }
    
    /**
     
     All the backgroundLayer config will be defined here
     
     */
    public struct BackgroundLayer {
        
        /// FullStage config
        public struct FullStage {
            /// Name of the sprite
            public static let stageSpriteName: String = "FullStage"
            /// Name to be set on full stage node
            public static let nodeName: String = "FullStage"
            
            private init(){}
        }
        private init(){}
    }
    
    /**

     All the foregroundLayer config will be defined here
     
     */
    public struct ForegroundLayer{
        
        /// Curtain config
        public struct Curtain{
            /// Name of the sprite
            public static let spriteName: String = "CurtainToAnimation"
            /// Name to be set on curtain node
            public static let nodeName: String = "CurtainToAnimation"
            
            private init(){}
        }        
        private init(){}
    }
    /**
     
     All the gameLayer config will be defined here
     
     */
    public struct GameLayer{
        
        /// Button Play & Pause config
        public struct ButtonPlayPause{
            
            /// Play texture name
            public static let playSpriteName: String = "Play"
            /// Pause texture name
            public static let pauseSpriteName: String = "Pause"
            
            private init(){}
        }
        
        /**

         This struct contains all the main config in the scene.
         
         The values here are controlling:
         how many singers will be placed in scene
         how much in each line
         how much gap between them
         how much size of each singer
         
         */
        public struct CharactersSetup{
            
            /// Total of singers in scene
            public static let total: Int = 13
            
            /// y axis size of a singer. This value will multiplier 1% Y Axis
            public static let ySizeMultiplier: CGFloat = 15
            /// x axis size of a singer. This value will multiplier 1% of X axis
            public static let xSizeMultiplier: CGFloat = 10.5 // Width must be 0.7 of Height value - ALWAYS
            
            /// All the config in the first row
            public struct FirstRow{
                /// How many singers
                public static let count: Int = 6
                /// Gap value between singers
                public static let gap: CGFloat = 12
                /// x Axis position in scene
                public static let xMultiplier: CGFloat = 20
                /// y Axis position in scene
                public static let yMultiplier: CGFloat = 28
            }
            /// All the config in the second row
            public struct SecondRow{
                /// How many singers
                public static let count: Int = 4
                /// Gap value between singers
                public static let gap: CGFloat = 12
                /// x Axis position in scene
                public static let xMultiplier: CGFloat = 20
                /// y Axis position in scene
                public static let yMultiplier: CGFloat = 52
                
            }
            /// All the config in the third row
            public struct ThirdRow{
                /// How many singers
                public static let count: Int = 3
                /// Gap value between singers
                public static let gap: CGFloat = 12
                /// x Axis position in scene
                public static let xMultiplier: CGFloat = 26
                /// y Axis position in scene
                public static let yMultiplier: CGFloat = 77
                
            }
            
            
            
        }
        /// This array of Singers sounds has the order sounds to each singer incremented in scene
        public static let sounds: [SingerSounds] = [SingerSounds.acoustic11, SingerSounds.soCal12, SingerSounds.grandPiano11, SingerSounds.cinematic11, SingerSounds.liverpool11 , SingerSounds.cinematic32,SingerSounds.cinematic22 ,SingerSounds.cinematic12, SingerSounds.acoustic12, SingerSounds.cinematic21, SingerSounds.cinematic31, SingerSounds.soCal11, SingerSounds.grandPiano12]
        
        private init() {}
        
    }
    
    private init(){}
}
