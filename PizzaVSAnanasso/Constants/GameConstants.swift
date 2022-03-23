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

struct positioning {
    static let frameX = UIScreen.main.bounds
    static let frameY = UIScreen.main.bounds
}
