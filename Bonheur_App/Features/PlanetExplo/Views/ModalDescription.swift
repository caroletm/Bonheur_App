//
//  ModalDescription.swift
//  Bonheur_App
//
//  Created by caroletm on 12/10/2025.
//

import SwiftUI

struct ModalDescription: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    @State var text: String = ""
    @Binding var dismissModalDescription: Bool
    
    var body: some View {
        
        ZStack {
                VStack {
                    Text("Donne plus de détails : ")
                        .padding()
                    TextEditor(text: $text)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxHeight: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                        )
                    Button {
                        souvenirsViewModel.descriptionText = text
                        mapViewModel.descriptionText = text
                        print(souvenirsViewModel.descriptionText)
                        print(mapViewModel.descriptionText)
                        dismissModalDescription = false
                        
                    }label:{
                        BoutonText(text: "OK", width: 45)
                            .padding(.top, 10)
                    }
                }
                .padding()
        }
    }
}

#Preview {
    ModalDescription(dismissModalDescription: .constant(false))
        .environment(MapViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}
