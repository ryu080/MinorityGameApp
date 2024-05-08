//
//  FitToDevices.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/07.
//

import SwiftUI

struct FrameFitToDevices: ViewModifier {

    var iPhone: (width:CGFloat?, height:CGFloat?)
    var iPhoneSE: (width:CGFloat?, height:CGFloat?)
    var iPad: (width:CGFloat?, height:CGFloat?)

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
                    .frame(width: iPhoneSE.width, height: iPhoneSE.height)
            } else if  screenSize > maxHeightSize{
                content
                    .frame(width: iPad.width, height: iPad.height)
            }else{
                content
                    .frame(width: iPhone.width, height: iPhone.height)
            }
        }
    }
}
