//
//  ModalAdresse.swift
//  Bonheur_App
//
//  Created by caroletm on 13/10/2025.
//

import SwiftUI

struct ModalAdresse: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @State var text: String = ""
    @Binding var closeAdressModal : Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    
                    Text("Rentre ton adresse : ")
                    
                    TextField("Ton adresse", text: $text)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                }
                .padding()
                Button {
                    closeAdressModal = false
                    mapViewModel.adressRentree = text
                }label : {
                    BoutonText(text: "OK", width: 45)
                }
            }
        }
    }
}

#Preview {
    ModalAdresse(closeAdressModal: .constant(false))
        .environment(NavigationViewModel())
        .environment(MapViewModel())
        .environment(SouvenirsViewModel())
}
