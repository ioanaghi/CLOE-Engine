//
//  ContentView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/06/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var engine = CognitiveEngine()
    
    var body: some View {
        HSplitView {
            // Main adaptive workspace area
            WorkspaceArea(score: engine.score, mode: engine.currentMode)
                .frame(minWidth: 550, minHeight: 450)
            
            // Biometric simulation & control sidebar
            DebugSidebar(engine: engine)
                .frame(width: 260)
        }
        .frame(minWidth: 850, minHeight: 500)
    }
}

struct WorkspaceArea: View {
    let score: Double
    let mode: CLOE_Mode
    
    var body: some View {
        ZStack {
            Color(score > 0.70 ? .black : .windowBackgroundColor)
                .animation(.easeInOut(duration: 0.4), value: score)
                .ignoresSafeArea()
            
            if mode == .neuralReset {
                VStack(spacing: 16) {
                    Circle()
                        .stroke(Color.cyan, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .scaleEffect(1.25)
                        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: score)
                    
                    Text("Cognitive Capacity Exceeded")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Neural recovery phase: breathe deeply.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    if score < 0.35 {
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
                        .font(.system(size: 22 + CGFloat(score * 8), weight: .bold))
                        .foregroundColor(score > 0.70 ? .white : .primary)
                    
                    Text("CLOE analyzes attention decay and reduces visual clutter in real-time. As the cognitive score rises, peripheral elements dissolve, contrast increases, and typography scales up dynamically to reduce visual cortex processing strain.")
                        .font(.system(size: 14 + CGFloat(score * 5)))
                        .lineSpacing(5 + CGFloat(score * 8))
                        .foregroundColor(score > 0.70 ? .white.opacity(0.9) : .primary)
                    
                    Spacer()
                }
                .padding(40)
                .animation(.spring(response: 0.45, dampingFraction: 0.8), value: score)
            }
        }
    }
}

struct DebugSidebar: View {
    @ObservedObject var engine: CognitiveEngine
    
    var body: some View {
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Simulated Cognitive Load: \(Int(engine.score * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
                
                Slider(value: $engine.score, in: 0...1, step: 0.01)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
    }
}
