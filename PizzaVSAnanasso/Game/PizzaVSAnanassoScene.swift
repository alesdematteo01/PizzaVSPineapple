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
    var ananasTexture: [SKTexture] = []
    
    let enemy: SKSpriteNode = SKSpriteNode(imageNamed: "enemyChef0")
    let enemy0 = SKTexture(imageNamed: "enemyChef0")
    let enemy1 = SKTexture(imageNamed: "enemyChef1")
    
    let tagliere0: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere1: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere2: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere3: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    
    
    override func sceneDidLoad() {
        //        self.setUpGame()
        self.setUpPhysicsWorld()
        self.setBackground()
        
        let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: Positioning.frameY.size.height/6)
        self.createPlayer(at: playerInitialPosition)
        generateAnanas()
        self.createEnemy()
        self.setTaglieri()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    //    private func setUpGame() {
    //        self.gameLogic.setUpGame()
    //
    //        self.setBackground()
    //
    //        let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: Positioning.frameY.size.height/6)
    //        self.createPlayer(at: playerInitialPosition)
    //        generateAnanas()
    //        self.createEnemy()
    //        self.setTaglieri()
    //
    //    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
        physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func setBackground() {
        backgroundImage.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        backgroundImage.zPosition = -1
        
        addChild(backgroundImage)
    }
    
    private func setTaglieri() {
        self.tagliere0.name = "tagliere0"
        self.tagliere1.name = "tagliere1"
        self.tagliere2.name = "tagliere2"
        self.tagliere3.name = "tagliere3"
        
        self.tagliere0.position = CGPoint(x: 0, y: 100)
        self.tagliere1.position = CGPoint(x: 0, y: 300)
        self.tagliere2.position = CGPoint(x: 0, y: 500)
        self.tagliere3.position = CGPoint(x: 0, y: 700)
        
        self.tagliere0.zPosition = 1
        self.tagliere1.zPosition = 1
        self.tagliere2.zPosition = 1
        self.tagliere3.zPosition = 1
        
        tagliere0.physicsBody = SKPhysicsBody(texture: tagliere0.texture!, size: tagliere0.size)
        tagliere0.physicsBody?.affectedByGravity = false
        
        tagliere1.physicsBody = SKPhysicsBody(texture: tagliere1.texture!, size: tagliere1.size)
        tagliere1.physicsBody?.affectedByGravity = false
        
        tagliere2.physicsBody = SKPhysicsBody(texture: tagliere2.texture!, size: tagliere2.size)
        tagliere2.physicsBody?.affectedByGravity = false
        
        tagliere3.physicsBody = SKPhysicsBody(texture: tagliere3.texture!, size: tagliere3.size)
        tagliere3.physicsBody?.affectedByGravity = false
        
        addChild(tagliere0)
        addChild(tagliere1)
        addChild(tagliere2)
        addChild(tagliere3)
        
    }
    
    private func createPlayer(at position: CGPoint) {
        player.name = "player"
        player.size = CGSize(width: 64, height: 64)
        player.position = position
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.pizza
        player.physicsBody?.collisionBitMask = PhysicsCategory.ananas
        player.physicsBody?.contactTestBitMask = PhysicsCategory.ananas
        
        
        addChild(self.player)
    }
    
    func generateAnanas() {
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 64, height: 64)
        ananas_default.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.midY)
        ananas_default.zPosition = 1
        
        for i in 0...3{
            ananasTexture.append(SKTexture(imageNamed: "pineapple_sprite\(i)"))
        }
        
        ananas_default.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        ananas_default.physicsBody?.categoryBitMask = PhysicsCategory.ananas
        ananas_default.physicsBody?.collisionBitMask = PhysicsCategory.pizza
        ananas_default.physicsBody?.contactTestBitMask = PhysicsCategory.pizza
        
        let animation = SKAction.animate(with: ananasTexture, timePerFrame:0.2)
        
        addChild(ananas_default)
        ananas_default.run(SKAction.repeatForever(animation))
        
    }
    
    private func createEnemy(){
        enemy.name = "enemy"
        enemy.size = CGSize(width: 64, height: 64)
        enemy.position = CGPoint(x: Positioning.frameX.width/3, y: Positioning.frameY.height/3)
        enemy.zPosition = 1
        
        let animation = SKAction.animate(with: [enemy0, enemy1], timePerFrame: 0.2)
        
        addChild(enemy)
        enemy.run(SKAction.repeatForever(animation))
    }
}

