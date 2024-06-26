//
//  BlurView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/22.
//

import SwiftUI

struct BlurView: View {
    let characters: Array<String.Element>
    let baseTime: Double
    let textSize: Double
    @State var blurValue: Double = 10
    @State var opacity: Double = 0

    init(text: String, textSize: Double, startTime: Double) {
        characters = Array(text)
        self.textSize = textSize
        baseTime = startTime
    }

    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(x: 10, y: 10, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            Spacer()
            HStack(spacing: 1) {
                ForEach(characters.indices, id: \.self) {index in
                    Text(String(self.characters[index]))
                        .font(.system(size: textSize))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .blur(radius: blurValue)
                        .opacity(opacity)
                        .animation(.easeInOut.delay(Double(index) * 0.15), value: blurValue)
                }
            }
            Spacer()
            .onAppear {
                animateBlur()
            }
        }
    }

    private func animateBlur() {
        DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
            withAnimation(.easeInOut(duration: 0.5)) {
                if blurValue == 0 {
                    blurValue = 10
                    opacity = 0.01
                } else {
                    blurValue = 0
                    opacity = 1
                }
            }
            // アニメーションが終了したら再度アニメーションを開始する
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateBlur()
            }
        }
    }
}

#Preview {
    BlurView(text: "集計中...", textSize: 50, startTime: 1)
}
