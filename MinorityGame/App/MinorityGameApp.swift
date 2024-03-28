//
//  MinorityGameApp.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

@main
struct MinorityGameApp: App {
    @StateObject var viewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(GameViewModel())
        }
    }
}
