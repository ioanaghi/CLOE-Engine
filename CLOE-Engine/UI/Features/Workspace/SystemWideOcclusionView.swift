//
//  SystemWideOcclusionView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 26/08/2026.
//

import SwiftUI

public struct SystemWideOcclusionView: View {
    @ObservedObject var engine: CognitiveEngine
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // When cognitive load is high, dim the entire screen
                if engine.score > 0.40 {
                    Color.black
                        .opacity(CGFloat((engine.score - 0.40) * 1.2)) // Scales up to ~72% darkness
                        .animation(.easeInOut(duration: 0.5), value: engine.score)
                        .ignoresSafeArea()
                }
                
                // Full Neural Reset lockout over the entire desktop
                if engine.currentMode == .neuralReset {
                    Color.black.ignoresSafeArea()
                    NeuralResetView(score: engine.score)
                }
            }
        }
    }
}
