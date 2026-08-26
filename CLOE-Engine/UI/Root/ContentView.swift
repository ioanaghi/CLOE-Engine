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
            WorkspaceArea(engine: engine)
                .frame(minWidth: 550, minHeight: 450)
            
            // Biometric simulation & control sidebar
            DebugSidebar(engine: engine)
                .frame(width: 270)
        }
        .frame(minWidth: 880, minHeight: 520)
    }
}

struct WorkspaceArea: View {
    @ObservedObject var engine: CognitiveEngine
    
    let sampleText = "CLOE analyzes attention decay and reduces visual clutter in real-time. As the cognitive score rises, peripheral elements dissolve, contrast increases, and typography scales up dynamically to reduce visual cortex processing strain."
    
    var body: some View {
        ZStack {
            // Background interpolates to OLED black under severe cognitive load
            Color(engine.score > 0.70 ? .black : .windowBackgroundColor)
                .animation(.easeInOut(duration: 0.4), value: engine.score)
                .ignoresSafeArea()
            
            if engine.currentMode == .neuralReset {
                VStack(spacing: 16) {
                    Circle()
                        .stroke(Color.cyan, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .scaleEffect(1.25)
                        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: engine.score)
                    
                    Text("Cognitive Capacity Exceeded")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Neural recovery phase: breathe deeply.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    // Secondary metadata fades out early
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
                        .foregroundColor(engine.score > 0.70 ? .white : .primary)
                    
                    // Strict Sequential Progressive Reading Mode
                    if engine.isFoveatedReadingActive {
                        SequentialUnlockingTextView(
                            text: sampleText,
                            fontSize: 14 + CGFloat(engine.score * 5),
                            isDarkMode: engine.score > 0.70,
                            engine: engine
                        )
                    } else {
                        Text(sampleText)
                            .font(.system(size: 14 + CGFloat(engine.score * 5)))
                            .lineSpacing(5 + CGFloat(engine.score * 8))
                            .foregroundColor(engine.score > 0.70 ? .white.opacity(0.9) : .primary)
                    }
                    
                    Spacer()
                }
                .padding(40)
                .animation(.spring(response: 0.45, dampingFraction: 0.8), value: engine.score)
            }
        }
    }
}

// Word Tokenizer requiring strict sequential unlocks
struct SequentialUnlockingTextView: View {
    let text: String
    let fontSize: CGFloat
    let isDarkMode: Bool
    @ObservedObject var engine: CognitiveEngine
    
    // Index of the highest word unlocked so far (-1 means nothing unlocked yet)
    @State private var unlockedIndex: Int = -1
    @State private var currentHoverTarget: Int? = nil
    
    private var words: [String] {
        text.components(separatedBy: " ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DynamicFlowLayout(spacing: 6) {
                ForEach(Array(words.enumerated()), id: \.offset) { index, word in
                    let isUnlocked = index <= unlockedIndex
                    let isCurrentFocus = index == unlockedIndex
                    let isNextInQueue = index == unlockedIndex + 1
                    
                    Text(word + " ")
                        .font(.system(size: fontSize, weight: isCurrentFocus ? .bold : .regular))
                        .foregroundColor(isDarkMode ? .white : .primary)
                        // Blurred and transparent if locked, revealed if unlocked
                        .blur(radius: isUnlocked ? 0.0 : (isNextInQueue ? 5.0 : 10.0))
                        .opacity(isUnlocked ? (isCurrentFocus ? 1.0 : 0.6) : (isNextInQueue ? 0.25 : 0.05))
                        .scaleEffect(isCurrentFocus ? 1.05 : 1.0)
                        .animation(.easeOut(duration: 0.18), value: unlockedIndex)
                        .onHover { inside in
                            if inside {
                                // Only unlock if the hovered word is the immediate next token
                                if index == unlockedIndex + 1 {
                                    unlockedIndex = index
                                    currentHoverTarget = index
                                }
                            }
                        }
                }
            }
            
            // Progress indication
            HStack {
                Text("Reading Sequence: \(unlockedIndex + 1) / \(words.count) words revealed")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Reset Progress") {
                    withAnimation {
                        unlockedIndex = -1
                    }
                }
                .buttonStyle(.borderless)
                .font(.caption2)
            }
            .padding(.top, 10)
        }
    }
}

// Flow Layout engine for natural typography breaking
struct DynamicFlowLayout: Layout {
    var spacing: CGFloat = 6
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 500
        var height: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxHeightInRow: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > width {
                x = 0
                y += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            maxHeightInRow = max(maxHeightInRow, size.height)
            x += size.width + spacing
        }
        height = y + maxHeightInRow
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var maxHeightInRow: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            maxHeightInRow = max(maxHeightInRow, size.height)
            x += size.width + spacing
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
            
            Divider()
            
            // Toggle for Sequential Lock Mode
            Toggle(isOn: $engine.isFoveatedReadingActive) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Sequential Lock Mode")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("All words hidden until revealed in strict order")
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
