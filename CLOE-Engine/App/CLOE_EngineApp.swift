//
//  CLOE_EngineApp.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/07/2026.
//

import SwiftUI

@main
struct CLOE_EngineApp: App {
    @StateObject private var overlayController = OverlayWindowController()
    @StateObject private var engine = CognitiveEngine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Activate desktop overlay on startup
                    overlayController.showOverlay(engine: engine)
                }
        }
        
        // Adds CLOE to the macOS Top Menu Bar
        MenuBarExtra("CLOE", systemImage: "brain.head.profile") {
            Button("Toggle Focus Overlay") {
                // Manual toggle
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
