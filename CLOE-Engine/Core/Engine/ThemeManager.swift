//
//  ThemeManager.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI
import Combine

public final class ThemeManager: ObservableObject, ThemeManaging {
    @Published public var selectedTheme: AppTheme = .system
    
    public init() {}
    
    public func effectiveBackgroundColor(for score: Double) -> Color {
        if score > 0.70 {
            return .black
        }
        
        switch selectedTheme {
        case .system:
            return Color(NSColor.windowBackgroundColor)
        case .light:
            return Color.white
        case .dark:
            return Color(NSColor.darkGray).opacity(0.3)
        case .neuralOLED:
            return Color.black
        }
    }
    
    public func effectiveTextColor(for score: Double) -> Color {
        if score > 0.70 {
            return .white
        }
        switch selectedTheme {
        case .system:
            return .primary
        case .light:
            return .black
        case .dark, .neuralOLED:
            return .white
        }
    }
}
