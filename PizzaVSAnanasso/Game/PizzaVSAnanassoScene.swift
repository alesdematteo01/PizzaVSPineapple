//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene, SKPhysicsContactDelegate {
    
//    var gameLogic: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic.shared
    
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "pizzaIdle1")
    let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: Positioning.frameY.size.height/6)

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

    
//MARK: Generate Random Ananas
    
    private func createAnanas() {
        let ananasPositioning = self.randomAnanasPosition()
        generateAnanas(at: ananasPositioning)
    }
    
    private func randomAnanasPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = Positioning.frameX.width - 25
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = frame.height - 25
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    func generateAnanas(at position: CGPoint){
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 64, height: 64)
        ananas_default.zPosition = 1 //to change with structured zPositioning
        ananas_default.position = position
        
        let animation = SKAction.animate(with: [ananas_0, ananas_1, ananas_2, ananas_3], timePerFrame:0.2)
        
        
        addChild(ananas_default)
        ananas_default.run(SKAction.repeatForever(animation))
        
       
    }
    
    func startAnanasCycle() {
        let createAnanasAction = SKAction.run(createAnanas)
        let waitAction = SKAction.wait(forDuration: 5.0)
        
        let createAndWaitAction = SKAction.sequence([createAnanasAction, waitAction])
        let ananasCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(ananasCycleAction)
    }
    
    override func sceneDidLoad() {
//        self.setUpGame()
        self.setUpPhysicsWorld()
        createAnanas()
        
        self.setBackground()
        
        self.createPlayer(at: playerInitialPosition)
        generateAnanas()
        self.createEnemy()
        self.setTaglieri()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveLeft()
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
//     func setUpGame() {
//        self.gameLogic.setUpGame()
//    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
        physicsWorld.contactDelegate = self
    }
    
//    private func restartGame() {
////        self.gameLogic.restartGame()
//    }
    
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
        
        self.tagliere0.position = CGPoint(x: Positioning.frameX.midX, y: 10)
        self.tagliere1.position = CGPoint(x: Positioning.frameX.maxX-50, y: 10)
        self.tagliere2.position = CGPoint(x: 50, y: 10)
        self.tagliere3.position = CGPoint(x: 0, y: 700)
        
        self.tagliere0.zPosition = 1
        self.tagliere1.zPosition = 1
        self.tagliere2.zPosition = 1
        self.tagliere3.zPosition = 1
        
        tagliere0.physicsBody = SKPhysicsBody(texture: tagliere0.texture!, size: tagliere0.size)
        tagliere0.physicsBody?.mass = 5000000
        tagliere0.physicsBody?.affectedByGravity = false
        
        tagliere1.physicsBody = SKPhysicsBody(texture: tagliere1.texture!, size: tagliere1.size)
        tagliere1.physicsBody?.mass = 5000000
        tagliere1.physicsBody?.affectedByGravity = false
        
        tagliere2.physicsBody = SKPhysicsBody(texture: tagliere2.texture!, size: tagliere2.size)
        tagliere2.physicsBody?.mass = 5000000
        tagliere2.physicsBody?.affectedByGravity = false
        
        tagliere3.physicsBody = SKPhysicsBody(texture: tagliere3.texture!, size: tagliere3.size)
        tagliere3.physicsBody?.mass = 5000000
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
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        player.physicsBody?.affectedByGravity = true
        
        addChild(self.player)
    }
    
    func generateAnanas(){
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 64, height: 64)
        ananas_default.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.midY)
        ananas_default.zPosition = 1
        
        for i in 0...3{
            ananasTexture.append(SKTexture(imageNamed: "pineapple_sprite\(i)"))
        }
        
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

// MARK: - Player Movement
extension PizzaVSAnanassoScene {
    private func moveLeft(){
        self.player.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
    }
    
    private func moveRight(){
        self.player.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
    }
}

