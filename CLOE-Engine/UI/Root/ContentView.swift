//
//  ContentView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/06/2026.
//

import SwiftUI

public struct ContentView: View {
    @StateObject private var engine = CognitiveEngine()
    @StateObject private var themeManager = ThemeManager()
    
    public var body: some View {
        HSplitView {
            WorkspaceAreaView(engine: engine, themeManager: themeManager)
                .frame(minWidth: 550, minHeight: 450)
            
            DebugSidebarView(engine: engine, themeManager: themeManager)
                // Use a flexible width constraint instead of a fixed width
                .frame(minWidth: 300, idealWidth: 320, maxWidth: 450)
        }
        .preferredColorScheme(themeManager.selectedTheme.colorScheme)
        .frame(minWidth: 900, minHeight: 520)
    }
}
