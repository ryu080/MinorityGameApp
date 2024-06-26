//
//  RootView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/31.
//

import SwiftUI

enum MainView{
    case editView
    case gameView
}

enum EditView{
    case startGameView
    case playerListView
}

enum GameView{
    case discussionView
    case voteListView
    case resultAnnouncementView
    case resultGameView
}
