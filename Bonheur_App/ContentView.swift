//
//  ContentView.swift
//  Bonheur_App
//
//  Created by caroletm on 11/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Patate Branch(Planete_User)")
                .font(.custom("SpaceMono-Regular", size: 24))
                .foregroundStyle(.greyDarkText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
