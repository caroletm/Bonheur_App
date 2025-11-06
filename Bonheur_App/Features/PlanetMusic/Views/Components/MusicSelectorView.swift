//
//  MusicSelectorView.swift
//  Bonheur_App
//
//  Vue principale affichant le cercle de sélection des musiques + le bouton Play central.
//  Created by Apprenant156 on 29/09/2025.
//

import SwiftUI

struct MusicSelectorView: View {
    @Bindable var viewModel: MusicPlayerViewModel

    var body: some View {
        ZStack {
            // Cercle de fond gris
            Circle()
                .fill(Color.greyDarkButton)
                .frame(width: 270, height: 270)

            // Boucle sur chaque thème musical pour créer un segment interactif
            ForEach(Array(viewModel.planeteMusic.themes.enumerated()), id: \.element.id) { index, theme in
                let sliceAngle = 360.0 / Double(viewModel.planeteMusic.themes.count)
                let start = Angle(degrees: Double(index) * sliceAngle - 90)
                let end = Angle(degrees: Double(index + 1) * sliceAngle - 90)

                SegmentButton(
                    label: theme.nom,
                    logo: theme.logo,
                    startAngle: start,
                    endAngle: end,
                    isSelected: viewModel.selectedSegment == index
                ) {
                    viewModel.handleSegmentTap(index: index)
                }
                .frame(width: 250, height: 250)
            }

            // Bouton Play/Pause central
            PlayButtonOctagon(
                isPlaying: $viewModel.isPlaying,
                selectedSegment: $viewModel.selectedSegment,
                action: viewModel.togglePlayPause
            )
        }
    }
}


#Preview {
    MusicSelectorView(viewModel: MusicPlayerViewModel(planeteMusic: planeteMusic))
}
