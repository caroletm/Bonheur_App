//
//  MemoryChallengeViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 01/10/2025.
//

import Foundation
import SwiftUI
@Observable
class MemoryChallengeViewModel{
    var descriptionText: String = ""
    var selectedTheme: ThemeType? = nil
    var image: UIImage? = nil
    var creationDate: Date = Date()
    
    func buildChallenge(name: String)-> MemoryChallenge?{
        guard let theme = selectedTheme else {return nil}
        return MemoryChallenge(nameMemory: name, descriptionMemory: descriptionText,themeMemory: theme)
    }
}
