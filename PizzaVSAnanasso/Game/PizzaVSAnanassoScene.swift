//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene, SKPhysicsContactDelegate {
    
    var gameLogic: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic.shared
    
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "pizzaIdle1"
    )
    let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background_level")
    
    var ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
    let ananas_0 = SKTexture(imageNamed: "pineapple_sprite0")
    let ananas_1 = SKTexture(imageNamed: "pineapple_sprite1")
    let ananas_2 = SKTexture(imageNamed: "pineapple_sprite2")
    let ananas_3 = SKTexture(imageNamed: "pineapple_sprite3")
    
    let enemy: SKSpriteNode = SKSpriteNode(imageNamed: "enemyChef0")
    let enemy0 = SKTexture(imageNamed: "enemyChef0")
    let enemy1 = SKTexture(imageNamed: "enemyChef1")
    
    override func sceneDidLoad() {
        self.setUpGame()
        self.setUpPhysicsWorld()
        
        let ananasAnimation = SKAction.animate(with: [ananas_0, ananas_1, ananas_2, ananas_3], timePerFrame:0.2)
        ananas_default.run(SKAction.repeatForever(ananasAnimation))

        
        let enemyAnimation = SKAction.animate(with: [enemy0, enemy1], timePerFrame: 0.2)
        enemy.run(SKAction.repeatForever(enemyAnimation))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    private func setUpGame() {
        self.gameLogic.setUpGame()
        
        self.setBackground()
        
        let playerInitialPosition = CGPoint(x: positioning.frameX.size.width/2, y: positioning.frameY.size.height/6)
        self.createPlayer(at: playerInitialPosition)
        self.generateAnanas()
        self.createEnemy()

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
        self.player.size = CGSize(width: 64, height: 64)
        self.player.position = position
        self.player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        player.physicsBody?.affectedByGravity = false
        
        addChild(self.player)
    }
    
    private func generateAnanas(){
        ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 64, height: 64)
        ananas_default.position = CGPoint(x: positioning.frameX.midX, y: positioning.frameY.midY)
        ananas_default.zPosition = 1
        ananas_default.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.midY)
        
        
        
        addChild(ananas_default)
        ananas_default.run(SKAction.repeatForever(animation))
    }
    
    
    override func sceneDidLoad() {
        
        self.setUpPhysicsWorld()
        
        generateAnanas()
    }
    
    private func createEnemy(){
        self.enemy.name = "enemy"
        self.enemy.size = CGSize(width: 64, height: 64)
        self.enemy.position = CGPoint(x: positioning.frameX.width/3, y: positioning.frameY.height/3)
        self.zPosition = 1
        
        
        addChild(enemy)
    }
}

// MARK: Game Scene Set Up
extension PizzaVSAnanassoScene {
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        physicsWorld.contactDelegate = self
    }
    
}

