//
//  PizzaVSAnanassoScene.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SpriteKit
import SwiftUI

class PizzaVSAnanassoScene: SKScene, SKPhysicsContactDelegate {
    
    override func sceneDidLoad() {
        
        self.setUpPhysicsWorld()
        
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

