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
    
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "pizzaIdle1")
    let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: Positioning.frameY.size.height/6)
    
    let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background_level")
    
    var ananas_default = SKSpriteNode()
    var ananasTexture: [SKTexture] = []
    
    let enemy: SKSpriteNode = SKSpriteNode(imageNamed: "enemyChef0")
    let enemy0 = SKTexture(imageNamed: "enemyChef0")
    let enemy1 = SKTexture(imageNamed: "enemyChef1")
    
    let tagliere0: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere1: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere2: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere3: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var play = SKSpriteNode()
    var pause = SKSpriteNode()
    var status_game : Bool = false
    
    enum SideOfTheScreen {
        case right, left
    }
    
    func sideTouched(for position: CGPoint) -> SideOfTheScreen {
        if position.x < self.frame.width / 2 {
            
            return .left
        } else {
            
            return .right
            
        }
    }
    
   
    
    func pause_game(){
                    
            pause = SKSpriteNode(imageNamed: "pause")
            pause.name = "pause"
            pause.size = CGSize(width: 54, height: 54)
            pause.position = CGPoint(x: Positioning.frameX.minX + 40, y: Positioning.frameY.maxY - 45)
            pause.zPosition = Layer.ananas + 1
            
            addChild(pause)
        
            status_game = true
            
        
    }
    
    func play_game(){
        
        if status_game == true {
            
            play = SKSpriteNode(imageNamed: "play")
            play.name = "play"
            play.position = CGPoint(x: Positioning.frameX.minX + 40, y: Positioning.frameY.maxY - 45)
            play.size = CGSize(width: 54, height: 54)
            play.zPosition = Layer.ananas + 1
            
            addChild(play)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            for node in self.nodes(at: location){
                if node.name == "pause" {
                    play_game()
                    self.scene?.isPaused = true
                    pause.removeFromParent()
                    
                } else if node.name == "play" {
                    pause_game()
                    self.scene?.isPaused = false
                    play.removeFromParent()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            switch sideTouched(for: location) {
            case .right:
                self.isMovingToTheRight = true
                print("ℹ️ Touching the RIGHT side.")
            case .left:
                self.isMovingToTheLeft = true
                print("ℹ️ Touching the LEFT side.")
            }
        }
        
    }
    
//MARK: Generate Random Ananas
    
    func generateAnanas(at position: CGPoint){
        ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 40, height: 40)
        ananas_default.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.midY)
        ananas_default.zPosition = 1
        
        ananas_default.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        ananas_default.physicsBody?.categoryBitMask = PhysicsCategory.ananas
        ananas_default.physicsBody?.collisionBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        ananas_default.physicsBody?.contactTestBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        
//        let animation = SKAction.animate(with: ananasTexture, timePerFrame:0.2)
        
        ananas_default.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        ananas_default.physicsBody?.affectedByGravity = true

        addChild(ananas_default)
        
        ananas_default.run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.removeFromParent()
        ]))

    }
    
    private func randomAnanasPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = Positioning.frameX.width - 25
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = frame.height - 25
        
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func createAnanas() {
        let ananasPositioning = self.randomAnanasPosition()
        generateAnanas(at: ananasPositioning)
    }
    
    func startAnanasCycle() {
        
        let createAnanasAction = SKAction.run(createAnanas)
        
        let waitAction = SKAction.wait(forDuration: 5.0)
        
        let createAndWaitAction = SKAction.sequence([createAnanasAction, waitAction])
        let ananasCycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(ananasCycleAction)
    }
    
    override func sceneDidLoad() {
        
        self.setUpPhysicsWorld()
   
        self.setBackground()
        
        self.createPlayer(at: playerInitialPosition)
        self.createEnemy()
        self.setTaglieri()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.run(self.startAnanasCycle),
                    SKAction.wait(forDuration: 3)])))
        })
        
        play_game()
        pause_game()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //        moveLeft()
        if isMovingToTheLeft {
            self.moveLeft()
        }
        if isMovingToTheRight {
            self.moveRight()
        }
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    //     func setUpGame() {
    //        self.gameLogic.setUpGame()
    //    }
    
    
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    
    
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
        tagliere0.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere0.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere0.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere1.physicsBody = SKPhysicsBody(texture: tagliere1.texture!, size: tagliere1.size)
        tagliere1.physicsBody?.mass = 5000000
        tagliere1.physicsBody?.affectedByGravity = false
        tagliere1.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere1.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere1.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere2.physicsBody = SKPhysicsBody(texture: tagliere2.texture!, size: tagliere2.size)
        tagliere2.physicsBody?.mass = 5000000
        tagliere2.physicsBody?.affectedByGravity = false
        tagliere2.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere2.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere2.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere3.physicsBody = SKPhysicsBody(texture: tagliere3.texture!, size: tagliere3.size)
        tagliere3.physicsBody?.mass = 5000000
        tagliere3.physicsBody?.affectedByGravity = false
        tagliere3.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere3.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere3.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        addChild(tagliere0)
        addChild(tagliere1)
        addChild(tagliere2)
        addChild(tagliere3)
        
    }
    
    private func createPlayer(at position: CGPoint) {
        player.name = "player"
        player.size = CGSize(width: 64, height: 52)
        player.position = position
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 26)
        player.physicsBody?.affectedByGravity = false
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.pizza
        player.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.cutter
        player.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.cutter
        
        addChild(self.player)
    }
    
    
    
    private func createEnemy(){
        enemy.name = "enemy"
        enemy.size = CGSize(width: 64, height: 64)
        enemy.position = CGPoint(x: Positioning.frameX.width/3, y: Positioning.frameY.height/3)
        enemy.zPosition = 1
        
        let animation = SKAction.animate(with: [enemy0, enemy1], timePerFrame: 0.2)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.chef
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.cutter | PhysicsCategory.pizza
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.cutter | PhysicsCategory.pizza
        
        addChild(enemy)
        enemy.run(SKAction.repeatForever(animation))
    }
}

// MARK: - Player Movement
extension PizzaVSAnanassoScene {
    private func moveLeft(){
        self.player.physicsBody?.applyForce(CGVector(dx: -100, dy: 0))
    }
    
    private func moveRight(){
        self.player.physicsBody?.applyForce(CGVector(dx: 100, dy: 0))
    }
}



