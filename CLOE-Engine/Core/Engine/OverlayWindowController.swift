//
//  OverlayWindowController.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 26/08/2026.
//

import Cocoa
import SwiftUI
import Combine

public final class OverlayWindowController: ObservableObject {
    private var overlayPanel: NSPanel?
    
    public init() {}
    
    public func showOverlay(engine: CognitiveEngine) {
        guard overlayPanel == nil, let mainScreen = NSScreen.main else { return }
        
        let panel = NSPanel(
            contentRect: mainScreen.frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        
        // Float above regular application windows
        panel.level = .floating
        panel.backgroundColor = .clear
        panel.isOpaque = false
        panel.hasShadow = false
        panel.ignoresMouseEvents = true // Allows clicks to pass through to underlying applications
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // Host the adaptive SwiftUI overlay
        panel.contentView = NSHostingView(rootView: SystemWideOcclusionView(engine: engine))
        panel.orderFrontRegardless()
        
        self.overlayPanel = panel
    }
    
    public func hideOverlay() {
        overlayPanel?.close()
        overlayPanel = nil
    }
}
