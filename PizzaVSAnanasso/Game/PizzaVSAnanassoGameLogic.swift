//
//  PizzaVSAnanassoGameLogic.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 23/03/22.
//

import Foundation

class PizzaVSAnanassoGameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic()
    
    // Function responsible to set up the game before it starts.
//    func setUpGame() {
//
//        self.currentScore = 0
//        self.sessionDuration = 0
//
//        self.isGameOver = false
//
//    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
                
        self.currentScore = self.currentScore + points
    }
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
//    func restartGame() {
//                
//        self.setUpGame()
//    }
//    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
}
