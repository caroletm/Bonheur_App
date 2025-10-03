//
//  LigneTiretView.swift
//  Bonheur_App
//
//  Created by cyrilH on 02/10/2025.
//

import SwiftUI

struct LigneTiretView: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.clear)
            .overlay(
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [8]))
                    .foregroundColor(.blueDark)
            )
            .padding(.horizontal)
            
    }
}

#Preview {
    LigneTiretView()
}
