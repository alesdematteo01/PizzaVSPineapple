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
    let tagliere4: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere5: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere6: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere7: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere8: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")
    let tagliere9: SKSpriteNode = SKSpriteNode(imageNamed: "tagliere")

    
//    var isMovingToTheRight: Bool = false
//    var isMovingToTheLeft: Bool = false
    
    var isIdle: Bool = true
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            switch sideTouched(for: location) {
            case .right:
                self.jumpRight()
                print("ℹ️ Touching the RIGHT side.")
            case .left:
                self.jumpLeft()
                print("ℹ️ Touching the LEFT side.")
            }
        }
        
    }
    
    override func sceneDidLoad() {
        //        self.setUpGame()
        self.setUpPhysicsWorld()
        
        self.setBackground()
        
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
    //     func setUpGame() {
    //        self.gameLogic.setUpGame()
    //    }
    
    
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.8)
        
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
        self.tagliere4.name = "tagliere4"
        self.tagliere5.name = "tagliere5"
        self.tagliere6.name = "tagliere6"
        self.tagliere7.name = "tagliere4"
        self.tagliere8.name = "tagliere5"
        self.tagliere9.name = "tagliere6"

        
        self.tagliere0.position = CGPoint(x: Positioning.frameX.midX, y: 10)
        self.tagliere1.position = CGPoint(x: Positioning.frameX.maxX-50, y: 10)
        self.tagliere2.position = CGPoint(x: 50, y: 10)
        self.tagliere3.position = CGPoint(x: 0, y: 700)
        self.tagliere4.position = CGPoint(x: Positioning.frameX.width - Positioning.frameX.width/3, y: 175)
        self.tagliere5.position = CGPoint(x: Positioning.frameX.width/3, y: 375)
        self.tagliere6.position = CGPoint(x: Positioning.frameX.width - Positioning.frameX.width/3, y: 575)
        self.tagliere7.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.height+10)
        self.tagliere8.position = CGPoint(x: Positioning.frameX.maxX-50, y: Positioning.frameY.height+10)
        self.tagliere9.position = CGPoint(x: 50, y: Positioning.frameY.height+10)

        
        self.tagliere0.zPosition = 1
        self.tagliere1.zPosition = 1
        self.tagliere2.zPosition = 1
        self.tagliere3.zPosition = 1
        self.tagliere4.zPosition = 1
        self.tagliere5.zPosition = 1
        self.tagliere6.zPosition = 1
        self.tagliere7.zPosition = 1
        self.tagliere8.zPosition = 1
        self.tagliere9.zPosition = 1
        
        self.tagliere4.size = CGSize(width: tagliere4.frame.width*2 , height: tagliere4.frame.height)
        self.tagliere5.size = CGSize(width: tagliere5.frame.width*2 , height: tagliere5.frame.height)
        self.tagliere6.size = CGSize(width: tagliere6.frame.width*2 , height: tagliere6.frame.height)

        
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
        
        tagliere4.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere4.physicsBody?.mass = 5000000
        tagliere4.physicsBody?.affectedByGravity = false
        tagliere4.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere4.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere4.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere5.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere5.physicsBody?.mass = 5000000
        tagliere5.physicsBody?.affectedByGravity = false
        tagliere5.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere5.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere5.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere6.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere6.physicsBody?.mass = 5000000
        tagliere6.physicsBody?.affectedByGravity = false
        tagliere6.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere6.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere6.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere7.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere7.physicsBody?.mass = 5000000
        tagliere7.physicsBody?.affectedByGravity = false
        tagliere7.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere7.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere7.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere8.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere8.physicsBody?.mass = 5000000
        tagliere8.physicsBody?.affectedByGravity = false
        tagliere8.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere8.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere8.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        tagliere9.physicsBody = SKPhysicsBody(texture: tagliere4.texture!, size: tagliere4.size)
        tagliere9.physicsBody?.mass = 5000000
        tagliere9.physicsBody?.affectedByGravity = false
        tagliere9.physicsBody?.categoryBitMask = PhysicsCategory.cutter
        tagliere9.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        tagliere9.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.pizza
        
        self.tagliere4.zRotation = 0.20
        self.tagliere5.zRotation = -0.20
        self.tagliere6.zRotation = 0.20

        
        addChild(tagliere0)
        addChild(tagliere1)
        addChild(tagliere2)
        addChild(tagliere3)
        addChild(tagliere4)
        addChild(tagliere5)
        addChild(tagliere6)
        addChild(tagliere7)
        addChild(tagliere8)
        addChild(tagliere9)
    }
    
    private func createPlayer(at position: CGPoint) {
        player.name = "player"
        player.size = CGSize(width: 64, height: 52)
        player.position = position
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 26)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = false
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.pizza
        player.physicsBody?.collisionBitMask = PhysicsCategory.ananas | PhysicsCategory.cutter
        player.physicsBody?.contactTestBitMask = PhysicsCategory.ananas | PhysicsCategory.cutter
        
        let xRange = SKRange(lowerLimit: Positioning.frameX.minX+player.frame.width/2, upperLimit: Positioning.frameX.maxX-player.frame.width/2)
        let xContraint = SKConstraint.positionX(xRange)
        
        self.player.constraints = [xContraint]
        
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
        
        ananas_default.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        ananas_default.physicsBody?.categoryBitMask = PhysicsCategory.ananas
        ananas_default.physicsBody?.collisionBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        ananas_default.physicsBody?.contactTestBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        
        let animation = SKAction.animate(with: ananasTexture, timePerFrame:0.2)
        
        addChild(ananas_default)
        ananas_default.run(SKAction.repeatForever(animation))
        
    }
    
    private func createEnemy(){
        enemy.name = "enemy"
        enemy.size = CGSize(width: 64, height: 64)
        enemy.position = CGPoint(x: Positioning.frameX.width/7, y: Positioning.frameY.height-20)
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
        self.player.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
    }
    
    private func moveRight(){
        self.player.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
    }
    
    private func jumpRight(){
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: 70, y: 250, duration: 0.5)
        // move down 20
        let jumpDownAction = SKAction.moveBy(x: 70, y: -250, duration: 0.5)
        // sequence of move yup then down
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        // make player run sequence
        player.run(jumpSequence)
    }
    private func jumpLeft(){
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: -70, y: 250, duration: 0.5)
        // move down 20
        let jumpDownAction = SKAction.moveBy(x: -70, y: -250, duration: 0.5)
        // sequence of move yup then down
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        // make player run sequence
        player.run(jumpSequence)
    }
}

