//
//  DebugSidebarView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public struct DebugSidebarView: View {
    @ObservedObject var engine: CognitiveEngine
    @ObservedObject var themeManager: ThemeManager
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("CLOE Controller")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("System State:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(engine.currentMode.rawValue)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            Divider()
            
            ThemeSelectorView(themeManager: themeManager)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Simulated Cognitive Load: \(Int(engine.score * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
                
                Slider(value: $engine.score, in: 0...1, step: 0.01)
            }
            
            Divider()
            
            Toggle(isOn: $engine.isFoveatedReadingActive) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Sequential Lock Mode")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("Forces strictly ordered token unlocks")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .toggleStyle(.switch)
            
            Spacer()
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
    }
}
