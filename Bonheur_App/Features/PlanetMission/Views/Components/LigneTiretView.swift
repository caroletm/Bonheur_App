//
//  LigneTiretView.swift
//  Bonheur_App
//
//  Created by cyrilH on 02/10/2025.
//

import SwiftUI

struct LigneTiretView: View {
    var body: some View {

        Line()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
            .foregroundColor(.blueDark)
            .frame(height: 1)
            .padding(.horizontal)
            
    }
}

#Preview {
    LigneTiretView()
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
