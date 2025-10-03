//
//  SouvenirFilter.swift
//  Bonheur_App
//
//  Created by caroletm on 02/10/2025.
//

import Foundation
import SwiftUI

struct SouvenirFilter {
    var month : Int?
    var year : Int?
    var isDefi : Bool = false
    var isMap : Bool = false
    var theme : [SouvenirTheme] = []
}
