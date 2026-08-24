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
            // Zona principală adaptivă
            WorkspaceArea(score: engine.score, mode: engine.currentMode)
                .frame(minWidth: 550, minHeight: 450)
            
            // Panou de control / simulare biometrică
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
                    
                    Text("Capacitate cognitivă depășită")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Pauză de reglare neuronală: respiră adânc.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    if score < 0.35 {
                        HStack {
                            Text("CAPITOLUL 1 • TEORIA SARCINII COGNITIVE")
                            Spacer()
                            Text("PRIORITATE MAXIMĂ")
                        }
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                    Text("Arhitectura Sistemelor Adaptive")
                        .font(.system(size: 22 + CGFloat(score * 8), weight: .bold))
                        .foregroundColor(score > 0.70 ? .white : .primary)
                    
                    Text("CLOE analizează degradarea atenției și reduce zgomotul vizual în timp real. Pe măsură ce scorul crește, elementele periferice sunt eliminate, contrastul este forțat, iar tipografia este scalată pentru a reduce efortul de procesare al cortexului vizual.")
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
                Text("Stare sistem:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(engine.currentMode.rawValue)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Scor Sarcină Cognitivă: \(Int(engine.score * 100))%")
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
