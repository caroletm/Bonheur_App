//
//  ModalDescription.swift
//  Bonheur_App
//
//  Created by caroletm on 12/10/2025.
//

import SwiftUI

struct ModalDescription: View {
    
    @State var text: String = ""
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    
                    Text("Donne plus de détails : ")
                    TextEditor(text: $text)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxHeight: .infinity)
                    
                }
                .padding()
                BoutonText(text: "OK", width: 45)
            }
        }
    }
}

#Preview {
    ModalDescription()
}
