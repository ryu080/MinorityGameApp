//
//  TextFitToDevices.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/07.
//

import SwiftUI
struct TextFitToDevices: ViewModifier {

    var iPhone: CGFloat
    var iPhoneSE: CGFloat
    var iPad: CGFloat

    private let screenSize = UIScreen.main.bounds.height
    private let minHeightSize:CGFloat = 812
    private let maxHeightSize:CGFloat = 932
    private let seSize:(width:CGFloat, height:CGFloat) = (width:375, height:667)
    private let miniPadSize:(width:CGFloat, height:CGFloat) = (width:768, height:1024)
    private let maxiPadSize:(width:CGFloat, height:CGFloat) = (width:1024, height:1366)

    func body(content: Content) -> some View {
        Group {
            if screenSize < minHeightSize {
                content
                    .font(.system(size: iPhoneSE))
            } else if  screenSize > maxHeightSize{
                content
                    .font(.system(size: iPad))
            }else{
                content
                    .font(.system(size: iPhone))
            }
        }
    }
}
