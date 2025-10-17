//
//  RectangleFondéDetail.swift
//  Bonheur_App
//
//  Created by caroletm on 16/10/2025.
//

import SwiftUI

struct RectangleFondDetail: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.white.opacity(0.8), location: 0.3),
                        .init(color: Color.blueGrey.opacity(0.9), location: 0.6),
                        .init(color: Color.blueDark.opacity(0.9), location: 1.0)
                    ]),
                    startPoint: UnitPoint(x: 0, y: -0.6),
                    endPoint: UnitPoint(x: 0, y: 1.9)
                ))
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth: 5)
                    .frame(width: 363, height: 623)
                    .cornerRadius(20)
            )
            .frame(width: 304, height: 500)
            .cornerRadius(20)
    }
}

#Preview {
    ZStack {
        Color.blueDark.ignoresSafeArea(edges: .all)
        RectangleFondDetail()
    }
}
