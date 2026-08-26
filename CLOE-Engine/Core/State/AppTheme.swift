//
//  AppTheme.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public enum AppTheme: String, CaseIterable, Identifiable {
    case system = "System Auto"
    case light = "Solar Light"
    case dark = "Onyx Dark"
    case neuralOLED = "Pure OLED"
    
    public var id: String { self.rawValue }
    
    public var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark, .neuralOLED: return .dark
        }
    }
}
