//
//  AlertViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/10.
//

import Foundation

enum AlertType {
    case error
    case success
    case delete
}

final class AlertViewModel: ObservableObject {
    @Published var alertType:AlertType = .error
    @Published var isShowAlert:Bool = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""

    func playerCountAlert() {
        alertTitle = "注意"
        alertMessage = "プレイヤーを3人以上\n追加してください。"
        alertType = .error
        isShowAlert.toggle()
    }
    func genreAlert(){
        alertTitle = "注意"
        alertMessage = "ジャンルを選択してください。"
        alertType = .error
        isShowAlert.toggle()
    }

    func playerNameAlert(name:String) {
            if name == "" {
                alertTitle = "注意"
                alertMessage = "プレイヤー名が入力されていません。\n1~8文字以内で入力してください。"
            } else {
                alertTitle = "注意"
                alertMessage = "プレイヤー名は\n8文字以内で入力してください。"
            }
        alertType = .error
        isShowAlert.toggle()
    }
    func deletePlayerAlert(name:String){
        alertTitle = "削除"
        alertMessage = "\(name)さんを\n削除してもよろしいですか？"
        alertType = .delete
        isShowAlert.toggle()
    }
    func gameStartAlert(gameCount:Int,genre:String){
        alertTitle = "確認"
        alertMessage = "ゲーム数：\(gameCount)\nジャンル：\(genre)\nゲームをスタートしてもよろしいですか？"
        alertType = .success
        isShowAlert.toggle()
    }

    func questionTextAlert(text:String) {
        if text == "" {
            alertTitle = "注意"
            alertMessage = "問題文を入力してください。"
            alertType = .error
        } else if text.count >= 53 {
            alertTitle = "注意"
            alertMessage = "52文字以内で入力してください。"
            alertType = .error
        }
        else {
            alertTitle = "確認"
            alertMessage = "\(text)\nで出題してもよろしいですか？"
            alertType = .success
        }
        isShowAlert.toggle()
    }

    func discussionAlert() {
        alertTitle = "確認"
        alertMessage = "Thinking Timeを\n終了してもよろしいですか？"
        alertType = .success
        isShowAlert.toggle()
    }

    func voteAlert(vote:Int,choice1:String,choice2:String) {
        if vote == 0{
            alertTitle = "注意"
            alertMessage = "「\(choice1)」か「\(choice2)」\nどちらかに投票してください。"
            alertType = .error
            isShowAlert.toggle()
        }else{
            alertTitle = "確認"
            if vote == 1{
                alertMessage = "「\(choice1)」でよろしいですか？"
            }else{
                alertMessage = "「\(choice2)」でよろしいですか？"
            }
            alertType = .success
            isShowAlert.toggle()
        }
    }

    func voteListAlert() {
            alertTitle = "注意"
            alertMessage = "全員の投票が終わっていません。"
            alertType = .error
            isShowAlert.toggle()
    }
}
