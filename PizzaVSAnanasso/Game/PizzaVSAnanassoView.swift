//
//  PizzaVSAnanassoView.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 23/03/22.
//

import Foundation
import SwiftUI
import SpriteKit

/**
 * # ArcadeGameView
 *   This view is responsible for presenting the game and the game UI.
 *  In here you can add and customize:
 *  - UI elements
 *  - Different effects for transitions in and out of the game scene
 **/

struct PizzaVSAnanassoView: View {
    
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    @StateObject var gameLogic: PizzaVSAnanassoGameLogic =  PizzaVSAnanassoGameLogic.shared
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { Positioning.frameX.size.width }
    private var screenHeight: CGFloat { Positioning.frameY.size.height }
    
    /**
     * # The Game Scene
     *   If you need to do any configurations on your game scene, like changing it's size
     *   for example, do it here.
     **/
    
    var arcadeGameScene: PizzaVSAnanassoScene {
        let scene = PizzaVSAnanassoScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        PizzaVSAnanassoView(currentGameState: .constant(GameState.playing))
    }
}
