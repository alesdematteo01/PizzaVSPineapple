//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene {
    
    var gameLogic: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic.shared
    
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "pizzaIdle1")
    var backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background_level")
    
    override func sceneDidLoad() {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    private func setUpGame() {
        self.gameLogic.setUpGame()
        
        self.setBackground()
        
        let playerInitialPosition = CGPoint(x: self.frame.width/2, y: self.frame.height/6)
        self.createPlayer(at: playerInitialPosition)

    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
//        physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func setBackground() {
        self.backgroundImage.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        self.zPosition = -1
        
        addChild(backgroundImage)
    }
    
    private func createPlayer(at position: CGPoint) {
        self.player.name = "player"
        
        self.player.position = position
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        player.physicsBody?.affectedByGravity = false
        
        addChild(self.player)
    }
}

