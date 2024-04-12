//
//  RootViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/12.
//

import Foundation

class RootViewModel: ObservableObject{
    @Published var mainView:MainView = .editView
    @Published var editView:EditView = .startGameView
    @Published var gameView:GameView = .questionView

    @Published var loadingView:Bool = false

}
