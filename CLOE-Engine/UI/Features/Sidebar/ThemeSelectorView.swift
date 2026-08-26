//
//  ThemeSelectorView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public struct ThemeSelectorView: View {
    @ObservedObject var themeManager: ThemeManager
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Interface Theme:")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Picker("Theme", selection: $themeManager.selectedTheme) {
                ForEach(AppTheme.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(.menu) // Changed to native macOS dropdown menu
            .labelsHidden() // Hides the redundant inline label
        }
    }
}
