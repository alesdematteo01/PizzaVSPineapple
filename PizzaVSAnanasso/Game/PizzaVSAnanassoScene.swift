//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene, SKPhysicsContactDelegate {
    
    //    stopwatch
    var seconds = 0
    var timer = Timer()
    var timeStarted = Bool()
    var activeTimer = SKLabelNode()
    
    var music = SKAudioNode()
    var backgroundEnd = SKSpriteNode()
    var endingSprite = SKSpriteNode()
    var endLabel = SKLabelNode()
    
    var isWinning : Bool = false
    
    var gameLogic: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic.shared
    
    var player = SKSpriteNode()
    //    let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: Positioning.frameY.size.height/6)
    let playerInitialPosition = CGPoint(x: Positioning.frameX.size.width/2, y: 10)
    
    
    let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background_level")
    
    var banana = SKSpriteNode()
    
    var ananas_default = SKSpriteNode()
    var ananasTexture: [SKTexture] = []
    var ananasso = SKSpriteNode()
    
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
    
    let pizzaIdle1 = SKTexture(imageNamed: "pizzaIdle1")
    let pizzaIdle2 = SKTexture(imageNamed: "pizzaIdle2")
    let pizzaJump = SKTexture(imageNamed: "pizzaJump1")
    let pizzaRun1 = SKTexture(imageNamed: "pizzaRun0")
    let pizzaRun2 = SKTexture(imageNamed: "pizzaRun1")
    let pizzaRun3 = SKTexture(imageNamed: "pizzaRun2")
    let pizzaJumpL = SKTexture(imageNamed: "pizzaJump1L")
    let pizzaRun1L = SKTexture(imageNamed: "pizzaRun0L")
    let pizzaRun2L = SKTexture(imageNamed: "pizzaRun1L")
    let pizzaRun3L = SKTexture(imageNamed: "pizzaRun2L")
    
    let pizzaWin1 = SKTexture(imageNamed: "victory0")
    let pizzaWin2 = SKTexture(imageNamed: "victory1")
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    
    let life0 = SKTexture(imageNamed: "lifePoint1")
    let life1 = SKTexture(imageNamed: "lifePoint2")
    var lifeCounter = 3
    var lifeSprite1 = SKSpriteNode()
    var lifeSprite2 = SKSpriteNode()
    var lifeSprite3 = SKSpriteNode()
    
    var isIdle: Bool = true
    
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
        pause.zPosition = Layer.buttons
        
        addChild(pause)
        
        status_game = true
        
        
    }
    
    func play_game(){
        
        if status_game == true {
            
            play = SKSpriteNode(imageNamed: "play")
            play.name = "play"
            play.position = CGPoint(x: Positioning.frameX.minX + 40, y: Positioning.frameY.maxY - 45)
            play.size = CGSize(width: 54, height: 54)
            play.zPosition = Layer.buttons
            
            addChild(play)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            switch sideTouched(for: location) {
            case .right:
                //                self.jumpRight()
                self.isMovingToTheRight = true
                print("ℹ️ Touching the RIGHT side.")
            case .left:
                //                self.jumpLeft()
                self.isMovingToTheLeft = true
                print("ℹ️ Touching the LEFT side.")
            }
            
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingToTheRight = false
        self.isMovingToTheLeft = false
    }
    
    //MARK: Generate Random Ananas
    
    func generateAnanas(){
        ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 40, height: 40)
        ananas_default.position = CGPoint(x: enemy.position.x + enemy.frame.width, y: enemy.position.y)
        ananas_default.zPosition = Layer.ananas
        
        ananas_default.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ananas_default.physicsBody?.categoryBitMask = PhysicsCategory.ananas
        ananas_default.physicsBody?.collisionBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        ananas_default.physicsBody?.contactTestBitMask = PhysicsCategory.pizza | PhysicsCategory.cutter
        
        ananas_default.physicsBody?.affectedByGravity = true
        
        addChild(ananas_default)
        let xRange = SKRange(lowerLimit: Positioning.frameX.minX+ananas_default.frame.width/2, upperLimit: Positioning.frameX.maxX-ananas_default.frame.width/2)
        let xContraint = SKConstraint.positionX(xRange)
        
        self.ananas_default.constraints = [xContraint]
    }
    
    override func sceneDidLoad() {
        
        self.startGame()
        self.stopWatchLabel()
        
        self.setUpPhysicsWorld()
        
        self.setBackground()
        
        self.createPlayer(at: playerInitialPosition)
        self.createEnemy()
        self.setTaglieri()
        self.lifePoint()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.run(self.generateAnanas),
                    SKAction.wait(forDuration: 3)])))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0, execute: {
            self.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.run(self.createBanana),
                    SKAction.wait(forDuration: 12.0)])))
        })
        
        pause_game()
        
        music = SKAudioNode(fileNamed: "song.mp3")
        music.autoplayLooped = true
        self.addChild(music)
        music.run(SKAction.changeVolume(to: 1, duration: 0))
    }
    
    //    MARK: Collision
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if firstBody.node!.name == "ananas" && secondBody.node!.name == "player" {
            if lifeCounter == 0 {
                print("you lose")
                //                game over
                self.gameOver()
            } else {
                firstBody.node!.removeFromParent()
                lifeCounter -= 1
                self.removeLifePoint()
                self.reAddLifePoint()
                print("minus ONE")
            }
        } else if firstBody.node!.name == "player" && secondBody.node!.name == "ananas" {
            if lifeCounter == 0 {
                print("you lose")
                //                game over
                self.gameOver()
            } else {
                secondBody.node!.removeFromParent()
                lifeCounter -= 1
                self.removeLifePoint()
                self.reAddLifePoint()
                print("minus ONE but second way")
            }
        } else if firstBody.node!.name == "player" && secondBody.node!.name == "enemy" {
            print("win")
            //            game win
            if isWinning == false {
                isWinning = true
                self.gameWin()
            }
        } else if firstBody.node!.name == "enemy" && secondBody.node!.name == "player" {
            print("win")
            if isWinning == false {
                isWinning = true
                self.gameWin()
            }
        } else if firstBody.node!.name == "ananas" && secondBody.node!.name == "tagliere0" {
            firstBody.node!.removeFromParent()
        } else if firstBody.node!.name == "tagliere0" && secondBody.node!.name == "ananas" {
            secondBody.node!.removeFromParent()
        } else if firstBody.node!.name == "ananas" && secondBody.node!.name == "tagliere1" {
            firstBody.node!.removeFromParent()
        } else if firstBody.node!.name == "tagliere1" && secondBody.node!.name == "ananas" {
            secondBody.node!.removeFromParent()
        } else if firstBody.node!.name == "ananas" && secondBody.node!.name == "tagliere2" {
            firstBody.node!.removeFromParent()
        } else if firstBody.node!.name == "tagliere2" && secondBody.node!.name == "ananas" {
            secondBody.node!.removeFromParent()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lifeCounter == 3 {
            lifeSprite1.alpha = 1
            lifeSprite2.alpha = 1
            lifeSprite3.alpha = 1
        } else if lifeCounter == 2 {
            lifeSprite1.alpha = 1
            lifeSprite2.alpha = 1
            lifeSprite3.alpha = 0.5
        } else if lifeCounter == 1 {
            lifeSprite1.alpha = 1
            lifeSprite2.alpha = 0.5
            lifeSprite3.alpha = 0.5
        } else {
            lifeSprite1.alpha = 0.5
            lifeSprite2.alpha = 0.5
            lifeSprite3.alpha = 0.5
        }
        if isMovingToTheLeft {
            self.jumpLeft()
        }
        if isMovingToTheRight {
            self.jumpRight()
        }
        if timeStarted {
            updateTimer()
        }
    }
}

//MARK: - Game Scene Set Up
extension PizzaVSAnanassoScene {
    //     func setUpGame() {
    //        self.gameLogic.setUpGame()
    //    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.8)
        
        physicsWorld.contactDelegate = self
    }
    
    //    private func restartGame() {
    ////        self.gameLogic.restartGame()
    //    }
    
    private func setBackground() {
        backgroundImage.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        backgroundImage.zPosition = Layer.background
        
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
        
        
        self.tagliere0.zPosition = Layer.cutter
        self.tagliere1.zPosition = Layer.cutter
        self.tagliere2.zPosition = Layer.cutter
        self.tagliere3.zPosition = Layer.cutter
        self.tagliere4.zPosition = Layer.cutter
        self.tagliere5.zPosition = Layer.cutter
        self.tagliere6.zPosition = Layer.cutter
        self.tagliere7.zPosition = Layer.cutter
        self.tagliere8.zPosition = Layer.cutter
        self.tagliere9.zPosition = Layer.cutter
        
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
        player = SKSpriteNode(imageNamed: "pizzaIdle1")
        player.name = "player"
        player.size = CGSize(width: 64, height: 52)
        player.position = position
        player.zPosition = Layer.pizza
        
        let animation = SKAction.animate(with: [pizzaIdle1, pizzaIdle2], timePerFrame: 0.2)
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
        player.run(SKAction.repeatForever(animation))
    }
    
    
    
    private func createEnemy(){
        enemy.name = "enemy"
        enemy.size = CGSize(width: 64, height: 64)
        enemy.position = CGPoint(x: Positioning.frameX.width/7, y: 700 + tagliere3.frame.height )
        
        enemy.zPosition = Layer.chef
        
        ananasso = SKSpriteNode(imageNamed: "ananasso")
        ananasso.name = "ananasso"
        ananasso.size = CGSize(width: 30, height: 30)
        ananasso.position = CGPoint(x: Positioning.frameX.width/7 - 40, y: 705 + tagliere3.frame.height )
        ananasso.zPosition = Layer.ananas
        addChild(ananasso)
        
        let animation = SKAction.animate(with: [enemy0, enemy1], timePerFrame: 0.2)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.chef
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.cutter | PhysicsCategory.pizza
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.cutter | PhysicsCategory.pizza
        
        let xRange = SKRange(lowerLimit: Positioning.frameX.minX+enemy.frame.width/2, upperLimit: Positioning.frameX.maxX-enemy.frame.width/2)
        let xContraint = SKConstraint.positionX(xRange)
        
        self.enemy.constraints = [xContraint]
        
        addChild(enemy)
        
        enemy.run(SKAction.repeatForever(animation))
    }
    
    
    
    private func lifePoint() {
        var i = 0.0
        lifeSprite1 = SKSpriteNode(imageNamed: "lifePoint1")
        lifeSprite1.name = "lifeSprite"
        lifeSprite1.zPosition = Layer.life
        lifeSprite1.position = CGPoint(x: Positioning.frameX.midX + 125 + (CGFloat(i) * 60), y: Positioning.frameY.height - 50)
        lifeSprite1.size = CGSize(width: 32, height: 32)
        
        let animation = SKAction.animate(with: [life0, life1], timePerFrame: 0.2)
        addChild(lifeSprite1)
        lifeSprite1.run(SKAction.repeatForever(animation))
        i += 0.5
        
        lifeSprite2 = SKSpriteNode(imageNamed: "lifePoint1")
        lifeSprite2.name = "lifeSprite2"
        lifeSprite2.zPosition = Layer.life
        lifeSprite2.position = CGPoint(x: Positioning.frameX.midX + 125 + (CGFloat(i) * 60), y: Positioning.frameY.height - 50)
        lifeSprite2.size = CGSize(width: 32, height: 32)
        addChild(lifeSprite2)
        lifeSprite2.run(SKAction.repeatForever(animation))
        i += 0.5
        
        lifeSprite3 = SKSpriteNode(imageNamed: "lifePoint1")
        lifeSprite3.name = "lifeSprite3"
        lifeSprite3.zPosition = Layer.life
        lifeSprite3.position = CGPoint(x: Positioning.frameX.midX + 125 + (CGFloat(i) * 60), y: Positioning.frameY.height - 50)
        lifeSprite3.size = CGSize(width: 32, height: 32)
        addChild(lifeSprite3)
        lifeSprite3.run(SKAction.repeatForever(animation))
        i += 0.5
        lifeCounter = 3
    }
    
    private func removeLifePoint() {
        lifeSprite1.removeFromParent()
        lifeSprite2.removeFromParent()
        lifeSprite3.removeFromParent()
    }
    private func reAddLifePoint() {
        addChild(lifeSprite1)
        addChild(lifeSprite2)
        addChild(lifeSprite3)
    }
}

// MARK: - Player Movement
extension PizzaVSAnanassoScene {
    
    private func jumpRight(){
        let animation = SKAction.animate(with: [pizzaRun3, pizzaRun2, pizzaRun1, pizzaJump], timePerFrame: 0.2)
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: 5, y: 15, duration: 0.2)
        // move down 20
        let jumpDownAction = SKAction.moveBy(x: 5, y: -15, duration: 0.2)
        // sequence of move yup then down
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        // make player run sequence
        player.run(jumpSequence)
        player.run(SKAction.repeatForever(animation))
        
    }
    private func jumpLeft(){
        let animation = SKAction.animate(with: [pizzaRun3L, pizzaRun2L, pizzaRun1L, pizzaJumpL], timePerFrame: 0.2)
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: -5, y: 15, duration: 0.2)
        // move down 20
        let jumpDownAction = SKAction.moveBy(x: -5, y: -15, duration: 0.2)
        // sequence of move yup then down
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        // make player run sequence
        player.run(jumpSequence)
        player.run(SKAction.repeatForever(animation))
    }
}


// MARK: Game Over and Game Win Condition
extension PizzaVSAnanassoScene {
    private func gameOver() {
        self.stopGameTimer()
        self.scene?.isPaused = true
        pause.removeFromParent()
        
        backgroundEnd.name = "backgroundEnd"
        backgroundEnd.zPosition = Layer.endBG
        backgroundEnd.color = SKColor.black
        backgroundEnd.size = CGSize(width: Positioning.frameX.maxX * 2, height: Positioning.frameY.maxY * 2)
        backgroundEnd.position = CGPoint(x: frame.minX, y: frame.minY)
        backgroundEnd.alpha = 0.5
        addChild(backgroundEnd)
        
        endingSprite = SKSpriteNode(imageNamed: "deadPizza")
        endingSprite.size = CGSize(width: 250, height: 250)
        endingSprite.position = CGPoint(x: Positioning.frameY.midX, y: Positioning.frameY.midY)
        endingSprite.name = "endingSprite"
        endingSprite.zPosition = Layer.endSprite
        endingSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(endingSprite)
        
        
        endLabel.name = "endLabel"
        endLabel = SKLabelNode(fontNamed: "Snes")
        endLabel.fontSize = 50
        endLabel.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        endLabel.zPosition = Layer.endSprite
        endLabel.text = "You Lose!"
        endLabel.color = SKColor.red
        endLabel.colorBlendFactor = 1
        addChild(endLabel)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            let scene : SKScene = PizzaVSAnanassoScene(size: (self.view?.bounds.size)!)
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(scene, transition: transition)
            self.lifeCounter = 3
        })
    }
    
    private func gameWin() {
        activeTimer.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.midY - 250)
        activeTimer.fontSize = 100
        self.stopGameTimer()
        self.scene?.isPaused = true
        pause.removeFromParent()
        
        backgroundEnd.name = "backgroundEnd"
        backgroundEnd.zPosition = Layer.endBG
        backgroundEnd.color = SKColor.black
        backgroundEnd.size = CGSize(width: Positioning.frameX.maxX * 2, height: Positioning.frameY.maxY * 2)
        backgroundEnd.position = CGPoint(x: frame.minX, y: frame.minY)
        backgroundEnd.alpha = 0.5
        addChild(backgroundEnd)
        
        let animation = SKAction.animate(with: [pizzaWin1, pizzaWin2], timePerFrame: 0.2)
        endingSprite = SKSpriteNode(imageNamed: "victory0")
        endingSprite.name = "endingSprite"
        endingSprite.zPosition = Layer.endSprite
        endingSprite.position = CGPoint(x: Positioning.frameY.midX, y: Positioning.frameY.midY+50)
        addChild(endingSprite)
        endingSprite.run(SKAction.repeatForever(animation))
        
        endLabel.name = "endLabel"
        endLabel = SKLabelNode(fontNamed: "Snes")
        endLabel.fontSize = 50
        endLabel.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        endLabel.zPosition = Layer.endSprite
        endLabel.text = "You Win!"
        endLabel.color = SKColor.red
        endLabel.colorBlendFactor = 1
        addChild(endLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            let scene : SKScene = PizzaVSAnanassoScene(size: (self.view?.bounds.size)!)
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(scene, transition: transition)
            
        })
    }
}

// MARK: Easter Egg
extension PizzaVSAnanassoScene {
    private func createBanana() {
        let bananaPosition = self.randomBananaPosition()
        newBanana(at: bananaPosition)
    }
    
    private func randomBananaPosition() -> CGPoint {
        let initialX : CGFloat = Positioning.frameX.maxX/4
        let finalX : CGFloat = (Positioning.frameX.maxX - initialX)
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY : CGFloat = Positioning.frameY.maxY
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func newBanana(at position: CGPoint) {
        banana = SKSpriteNode(imageNamed: "banana")
        banana.name = "banana"
        banana.size = CGSize(width: 32, height: 32)
        banana.position = position
        
        banana.zPosition = Layer.endBG
        
        banana.physicsBody = SKPhysicsBody(rectangleOf: banana.size)
        banana.physicsBody?.categoryBitMask = PhysicsCategory.banana
        banana.physicsBody?.collisionBitMask = PhysicsCategory.banana
        banana.physicsBody?.contactTestBitMask = PhysicsCategory.banana
        banana.physicsBody?.affectedByGravity = true
        
        addChild(banana)
    }
}

// MARK: Stopwatch

extension PizzaVSAnanassoScene {
    
    
    func startGame() {
        
        startGameTimer()
        timeStarted = true
    }
    
    func resetGame() {
        
        timeStarted = false
        stopGameTimer()
        seconds = 0
    }
    
    func startGameTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        activeTimer.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        //        let minutes = Int(time) / 60 % 60
        //        let seconds = Int(time) % 60
        //        let milliseconds = Int(time) % 60 / 60
        //        return String(format:"%02i:%02i.%02i", minutes, seconds, milliseconds)
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i.%02i", hours, minutes, seconds)
    }
    
    
    func stopGameTimer() {
        timer.invalidate()
        removeAction(forKey: "timer")
    }
    
    func stopWatchLabel() {
        activeTimer.name = "activeTimer"
        activeTimer = SKLabelNode(fontNamed: "Snes")
        activeTimer.fontSize = 30
        activeTimer.position = CGPoint(x: Positioning.frameX.midX, y: Positioning.frameY.height - 65)
        activeTimer.zPosition = Layer.endSprite
        activeTimer.color = SKColor.red
        activeTimer.colorBlendFactor = 1
        addChild(activeTimer)
    }
    
}


