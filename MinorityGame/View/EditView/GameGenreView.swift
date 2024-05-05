//
//  GameGenreView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/05.
//

import SwiftUI

struct GameGenreView: View {
    @EnvironmentObject var genreViewModel:GenreViewModel
        var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    GenreButton(buttonText: "日常", buttonColor: .gray, backgroundColor: .white, tapButtonColor: .mint, tapBackgroundColor: .mint.opacity(0.2), buttonIndex: 0)
                        .environmentObject(genreViewModel)
                    Spacer()
                    GenreButton(buttonText: "恋愛", buttonColor: .gray, backgroundColor: .white, tapButtonColor: .mint, tapBackgroundColor: .mint.opacity(0.2), buttonIndex: 1)
                        .environmentObject(genreViewModel)
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    GenreButton(buttonText: "価値観", buttonColor: .gray, backgroundColor: .white, tapButtonColor: .mint, tapBackgroundColor: .mint.opacity(0.2), buttonIndex: 2)
                        .environmentObject(genreViewModel)
                    Spacer()
                    GenreButton(buttonText: "もしも", buttonColor: .gray, backgroundColor: .white, tapButtonColor: .mint, tapBackgroundColor: .mint.opacity(0.2), buttonIndex: 3)
                        .environmentObject(genreViewModel)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: 250,height: 150)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.mint, lineWidth: 1)
        )
        .shadow(radius: 5)
    }
}

#Preview {
    GameGenreView()
        .environmentObject(GenreViewModel())
}
