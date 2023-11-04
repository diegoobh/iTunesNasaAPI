//
//  NasaAPIProjectApp.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 3/11/23.
//

import SwiftUI

class AppState : ObservableObject{
    @Published var view : Int = 0
}

@main
struct NasaAPIProjectApp: App {
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if(appState.view == 0){
                ITunesView(view : $appState.view)
            }else{
                NasaView(view: $appState.view)
            }
        }
    }
}

