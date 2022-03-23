//
//  ContentView.swift
//  PizzaVSAnanasso
//
//  Created by Alessandra De Matteo on 22/03/22.
//

import SwiftUI
import SpriteKit

/**
 * # ContentView
 *
 *   This view is responsible for managing the states of the game, presenting the proper view.
 **/

struct ContentView: View {
    
    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .playing
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: PizzaVSAnanassoGameLogic = PizzaVSAnanassoGameLogic()
    
    
    var body: some View {

        switch currentGameState {
        case .mainScreen:
//            MainScreenView(currentGameState: $currentGameState)
//                .environmentObject(gameLogic)
            Text("gfer")
        
        case .playing:
            PizzaVSAnanassoView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .gameOver:
//            GameOverView(currentGameState: $currentGameState)
//                .environmentObject(gameLogic)
            Text("fe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
