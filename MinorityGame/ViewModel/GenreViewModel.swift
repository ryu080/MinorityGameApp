//
//  GenreViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/05.
//

import Foundation

class GenreViewModel:ObservableObject {

    @Published var buttonStates = Array(repeating: false, count: 4)
    @Published var genreName:String?

    func updateButtonState(buttonIndex: Int) {
        buttonStates = buttonStates.enumerated().map { (index, state) in
            return index == buttonIndex ? !state : false
        }
        switch buttonIndex {
        case 0:genreName = "日常"
        case 1:genreName = "恋愛"
        case 2:genreName = "価値観"
        case 3:genreName = "もしも"
        default:
            genreName = nil
        }
    }
}
