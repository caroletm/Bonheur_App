//
//  DetailMapPoint.swift
//  Bonheur_App
//
//  Created by caroletm on 16/10/2025.
//

import SwiftUI
import CoreLocation

struct DetailMapPoint: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    
    var mapPoint: MapPointDTO
    @State var address : String?
    
    var body: some View {
        
        ZStack {
            RectangleFondDetail()
            VStack {
                VStack {
                    Text(mapPoint.nom)
                        .font(.custom("SpaceMono-Bold", size: 18))
                    
                    if let address = address {
                        Text(address)
                            .font(.custom("SpaceMono-Bold", size: 12))
                            .frame(maxWidth : .infinity, maxHeight : 50)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    
                    if mapPoint.photo != "" {
                        
                        HStack (alignment: .top, spacing: 10) {
                            if let image = mapViewModel.loadImage(from: mapPoint.photo ?? "photoDog") {
                                ZStack {
                                    Image(uiImage: image )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 106, height: 138)
                                    Image(.pointGps)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height:  40)
                                        .offset(y : 70)
                                }
                                
                                ScrollView {
                                    Text(mapPoint.description)
                                        .font(.custom("Poppins-Regular", size: 12))
                                        .frame(maxWidth : 150, maxHeight : 190)
                                    //                                .background(Color.white.opacity(0.1))
                                }
                 
                            }
                        }.padding(10)
                    }else{
                        VStack{
                            Image(.pointGps)
                                .resizable()
                                .scaledToFit()
                                .frame(height:  40)
                                .padding()
                            ScrollView {
                                Text(mapPoint.description)
                                    .font(.custom("Poppins-Regular", size: 12))
                                //                                .background(Color.white.opacity(0.1))
                            }
                            .frame(maxWidth : 250, maxHeight : 120)
                        }
                    }
                }
                .task {
                    let coordinate = CLLocationCoordinate2D(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
                    address = await mapViewModel.getAddress(from: coordinate)
                }
              
            }
            .frame(width: 363, height: 623)
            .offset(y: mapPoint.photo == "" ? 0 : 140)
            
            VStack {
                Image(mapPoint.theme.iconName)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .shadow(color : mapPoint.theme.color, radius: 15)
                Text(mapPoint.theme.title)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .offset(y: -245)
            .padding(.bottom, 20)
            
            
            Button {
                mapViewModel.selectedMapPoint = nil
                mapViewModel.showDetailPopup = false
                print("popup: \(mapViewModel.showDetailPopup)")
                
            }label: {
                BoutonText(text: "OK", width: 45)
            }
            .padding()
            .offset(y: 200)
        }
    }
}

#Preview {
    ZStack{
        Color.blueDark.ignoresSafeArea(edges: .all)
        DetailMapPoint(mapPoint: mapPoints[1])
            .environment(NavigationViewModel())
            .environment(MapViewModel())
    }
}
