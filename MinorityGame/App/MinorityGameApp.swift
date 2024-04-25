//
//  MinorityGameApp.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MinorityGameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var rootViewModel = RootViewModel()
    @StateObject var gameViewModel = GameViewModel()
    @StateObject var dateViewModel = RealmViewModel()
    @StateObject var alertViewModel = AlertViewModel()
    @StateObject var questionViewModel = QuestionViewModel()

    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(rootViewModel)
                .environmentObject(gameViewModel)
                .environmentObject(dateViewModel)
                .environmentObject(alertViewModel)
                .environmentObject(questionViewModel)
        }
    }
}
