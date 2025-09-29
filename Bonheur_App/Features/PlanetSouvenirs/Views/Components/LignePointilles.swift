//
//  LignePointilles.swift
//  Bonheur_App
//
//  Created by caroletm on 29/09/2025.
//
import SwiftUI

struct LignePointilles: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.clear)
            .overlay(
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.white)
            )
            .padding(.horizontal)
            .padding(.top, 10)
    }
}

#Preview {
    ZStack{
        Color.blueDark.ignoresSafeArea(.all)
        LignePointilles()
    }
}
