//
//  WorkspaceAreaView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public struct WorkspaceAreaView: View {
    @ObservedObject var engine: CognitiveEngine
    @ObservedObject var themeManager: ThemeManager
    
    let sampleText = "CLOE analyzes attention decay and reduces visual clutter in real-time. As the cognitive score rises, peripheral elements dissolve, contrast increases, and typography scales up dynamically to reduce visual cortex processing strain."
    
    public var body: some View {
        ZStack {
            themeManager.effectiveBackgroundColor(for: engine.score)
                .animation(.easeInOut(duration: 0.4), value: engine.score)
                .ignoresSafeArea()
            
            if engine.currentMode == .neuralReset {
                NeuralResetView(score: engine.score)
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    if engine.score < 0.35 {
                        HStack {
                            Text("CHAPTER 1 • COGNITIVE LOAD THEORY")
                            Spacer()
                            Text("HIGH PRIORITY")
                        }
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                    Text("Adaptive Interface Architecture")
                        .font(.system(size: 22 + CGFloat(engine.score * 8), weight: .bold))
                        .foregroundColor(themeManager.effectiveTextColor(for: engine.score))
                    
                    if engine.isFoveatedReadingActive {
                        SequentialUnlockingTextView(
                            text: sampleText,
                            fontSize: 14 + CGFloat(engine.score * 5),
                            textColor: themeManager.effectiveTextColor(for: engine.score)
                        )
                    } else {
                        Text(sampleText)
                            .font(.system(size: 14 + CGFloat(engine.score * 5)))
                            .lineSpacing(5 + CGFloat(engine.score * 8))
                            .foregroundColor(themeManager.effectiveTextColor(for: engine.score).opacity(0.9))
                    }
                    
                    Spacer()
                }
                .padding(40)
                .animation(.spring(response: 0.45, dampingFraction: 0.8), value: engine.score)
            }
        }
    }
}

