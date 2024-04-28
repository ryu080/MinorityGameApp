//
//  RootViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/12.
//

import Foundation

final class RootViewModel: ObservableObject {
    @Published var mainView:MainView = .editView
    @Published var editView:EditView = .startGameView
    @Published var gameView:GameView = .discussionView

    @Published var loadingView:Bool = false

    func nextMainView(nextView:MainView){
        mainView = nextView
    }

    func nextEditView(nextView:EditView){
        if mainView == .gameView {
            mainView = .editView
        }
        editView = nextView
    }

    func nextGameView(nextView:GameView){
        if mainView == .editView {
            mainView = .gameView
        }
        gameView = nextView
    }
}
