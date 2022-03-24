//
//  GameConstants.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 23/03/22.
//

import Foundation

import SwiftUI

/**
 * # Constants
 *
 * This file gathers contant values that are shared all around the project.
 * Modifying the values of these constants will reflect along the complete interface of the application.
 *
 **/


/**
 * # GameState
 * Defines the different states of the game.
 * Used for supporting the navigation in the project template.
 */

enum GameState {
    case mainScreen
    case playing
    case gameOver
}


struct PhysicsCategory {
    static let pizza : UInt32 = 0x1 << 0
    static let ananas : UInt32 = 0x1 << 1
    static let chef : UInt32 = 0x1 << 2
    static let cutter : UInt32 = 0x1 << 3
    static let banana : UInt32 = 0x1 << 4
}

struct Layer {
    static let background : CGFloat = -3
    static let pizza : CGFloat = 1
    static let chef : CGFloat = 2
    static let ananas : CGFloat = 3
    static let cutter : CGFloat = 4
    static let life : CGFloat = 5
    static let buttons : CGFloat = 10
    static let endBG : CGFloat = 11
    static let endSprite : CGFloat = 12
}
    
struct Positioning {
    static let frameX = UIScreen.main.bounds
    static let frameY = UIScreen.main.bounds
}
