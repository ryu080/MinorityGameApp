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

class AlertViewModel: ObservableObject {
    @Published var alertType:AlertType = .error
    @Published var isShowAlert:Bool = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""

    func playerCountAlert(){
        alertTitle = "注意"
        alertMessage = "3人以上プレイヤーを追加してください。"
        alertType = .error
        isShowAlert.toggle()
    }

    func playerNameAlert(name:String){
            if name == ""{
                alertTitle = "注意"
                alertMessage = "プレイヤー名が入力されていません。\n1~8文字以内で入力してください。"
            }else{
                alertTitle = "注意"
                alertMessage = "プレイヤー名は\n8文字以内で入力してください。"
            }
        alertType = .error
        isShowAlert.toggle()
    }

    func questionTextAlert(text:String){
        if text == ""{
            alertTitle = "注意"
            alertMessage = "問題文を入力してください。"
            alertType = .error
        }else if text.count >= 53{
            alertTitle = "注意"
            alertMessage = "52文字以内で入力してください。"
            alertType = .error
        }
        else{
            alertTitle = "確認"
            alertMessage = "\(text)\nで出題してもよろしいですか？"
            alertType = .success
        }
        isShowAlert.toggle()
    }

    func discussionAlert(){
        alertTitle = "確認"
        alertMessage = "Thinking Timeを\n終了してもよろしいですか？"
        alertType = .success
        isShowAlert.toggle()
    }
    func voteAlert(){
        alertTitle = "注意"
        alertMessage = "YESかNO\nどちらかに投票してください。"
        alertType = .error
        isShowAlert.toggle()
    }

    func voteListAlert(){
            alertTitle = "注意"
            alertMessage = "全員の投票が終わっていません。"
            alertType = .error
            isShowAlert.toggle()
    }
}
