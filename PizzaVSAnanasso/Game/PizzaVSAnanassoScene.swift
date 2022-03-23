//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene, SKPhysicsContactDelegate {
    
    var ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
    let ananas_0 = SKTexture(imageNamed: "pineapple_sprite0")
    let ananas_1 = SKTexture(imageNamed: "pineapple_sprite1")
    let ananas_2 = SKTexture(imageNamed: "pineapple_sprite2")
    let ananas_3 = SKTexture(imageNamed: "pineapple_sprite3")

    
    private func createAnanas() {
        let ananasPositioning = self.randomAnanasPosition()
        generateAnanas(at: ananasPositioning)
    }
    
    private func randomAnanasPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = self.frame.width - 25
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = frame.height - 25
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    func generateAnanas(at position: CGPoint){
        ananas_default = SKSpriteNode(imageNamed: "pineapple_sprite0")
        ananas_default.name = "ananas"
        ananas_default.size = CGSize(width: 40, height: 40)
        ananas_default.zPosition = 1 //to change with structured zPositioning
        ananas_default.position = CGPoint(x: positioning.frameX.midX, y: positioning.frameY.midY)
        
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
        
        self.setUpPhysicsWorld()
        
        generateAnanas()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

// MARK: Game Scene Set Up
extension PizzaVSAnanassoScene {
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        physicsWorld.contactDelegate = self
    }
    
}

