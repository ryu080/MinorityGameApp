//
//  GenreButton.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/05.
//

import SwiftUI

struct GenreButton: View {
    @EnvironmentObject private var genreViewModel:GenreViewModel

    @State var buttonText:String
    @State var buttonColor:Color
    @State var backgroundColor:Color
    @State var tapButtonColor:Color
    @State var tapBackgroundColor:Color
    @State var buttonIndex:Int

    var body: some View {
        Button {
            genreViewModel.updateButtonState(buttonIndex: buttonIndex)
        } label: {
            Text(buttonText)
                .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 17, iPad: 40))
                .bold()
                .foregroundStyle( genreViewModel.buttonStates[buttonIndex] ? tapButtonColor: buttonColor)
        }
        .modifier(FrameFitToDevices(iPhone: (width: 80, height: 35),
                               iPhoneSE: (width: 80, height: 30),
                               iPad: (width: 200, height: 70)))
        .background(genreViewModel.buttonStates[buttonIndex] ? tapBackgroundColor: backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(genreViewModel.buttonStates[buttonIndex] ? tapButtonColor: buttonColor, lineWidth: 2)
        )
    }
}

#Preview {
    GenreButton(buttonText: "日常",
                buttonColor: Color.white,
                backgroundColor: Color.white,
                tapButtonColor: Color.mint,
                tapBackgroundColor: Color.mint.opacity(0.2),
                buttonIndex: 0)
    .environmentObject(GenreViewModel())
}
