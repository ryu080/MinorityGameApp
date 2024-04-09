//
//  TimerViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/01.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {

    @Published var timer:Timer?
    @Published var timeCount:Time = Time(minutesCount: 3, secondsCount: 0)

    func dateFormat(minutes:Int, seconds: Int) -> String {
        return String(format: "%2d:%02d", minutes, seconds)
    }

    func setCountDown(){
        timeCount = Time(minutesCount: 3, secondsCount: 0)
    }

    func startCountDown(){
        // Timerの実態があるときは停止させる
        self.timer?.invalidate()
        // Timer取得
        if self.timeCount.minutesCount == 0 && self.timeCount.secondsCount == 0 {
        }else{
            self.timer = Timer.scheduledTimer(withTimeInterval:1, repeats: true){ time in
                if  (self.timeCount.minutesCount == 0 && self.timeCount.secondsCount == 0){
                    self.timer?.invalidate()
                    self.timer = nil
                } else if self.timeCount.secondsCount == 0 {
                    self.timeCount.minutesCount -= 1
                    self.timeCount.secondsCount = 59
                }else{
                    self.timeCount.secondsCount -= 1
                }
            }
        }
    }

    func plusMinutes(){
        if timeCount.minutesCount < 59 {
            timeCount.minutesCount += 1
        }
    }
    func minusMinutes(){
        if timeCount.minutesCount > 0 {
            timeCount.minutesCount -= 1
        }
    }

    func stopCountDown(){
        timer?.invalidate()
        timer = nil
    }

}
