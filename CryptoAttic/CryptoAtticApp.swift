//
//  CryptoAtticApp.swift
//  CryptoAttic
//
//  Created by Tanmay . on 21/11/24.
//

import SwiftUI

@main
struct CryptoAtticApp: App {
    // The instance of HomeViewModel is given here so that to make it an environment object which can be called from any view in the app
    @StateObject private var vm = HomeViewModel()
    
    init() {
        // This is being used to convert the NavigationTitle's .foregroundStyle since it cant be changed with modifiers:
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
