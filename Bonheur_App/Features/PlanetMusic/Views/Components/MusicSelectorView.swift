//
//  MusicSelectorView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//
//
//  MusicSelectorView.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 29/09/2025.
//
import SwiftUI
import AVFoundation


struct MusicSelectorView: View {
    @ObservedObject var viewModel: MusicPlayerViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.greyDarkButton)
                .frame(width: 270, height: 270)
            
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
