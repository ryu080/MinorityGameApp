//
//  SlideUpTransition.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/03.
//

import SwiftUI

struct SlideUpTransition: ViewModifier {
    var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .animation(.easeInOut(duration: 0.5))
    }
}

