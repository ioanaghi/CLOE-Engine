//
//  SequentialUnlockingTextView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public struct SequentialUnlockingTextView: View {
    public let text: String
    public let fontSize: CGFloat
    public let textColor: Color
    
    @State private var unlockedIndex: Int = -1
    
    private var words: [String] {
        text.components(separatedBy: " ")
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DynamicFlowLayout(spacing: 6) {
                ForEach(Array(words.enumerated()), id: \.offset) { index, word in
                    let isUnlocked = index <= unlockedIndex
                    let isCurrentFocus = index == unlockedIndex
                    let isNextInQueue = index == unlockedIndex + 1
                    
                    Text(word + " ")
                        .font(.system(size: fontSize, weight: isCurrentFocus ? .bold : .regular))
                        .foregroundColor(textColor)
                        .blur(radius: isUnlocked ? 0.0 : (isNextInQueue ? 5.0 : 10.0))
                        .opacity(isUnlocked ? (isCurrentFocus ? 1.0 : 0.6) : (isNextInQueue ? 0.25 : 0.05))
                        .scaleEffect(isCurrentFocus ? 1.05 : 1.0)
                        .animation(.easeOut(duration: 0.18), value: unlockedIndex)
                        .onHover { inside in
                            if inside && index == unlockedIndex + 1 {
                                unlockedIndex = index
                            }
                        }
                }
            }
            
            HStack {
                Text("Progress: \(unlockedIndex + 1) / \(words.count) tokens")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Button("Reset Progress") {
                    withAnimation { unlockedIndex = -1 }
                }
                .buttonStyle(.borderless)
                .font(.caption2)
            }
            .padding(.top, 10)
        }
    }
}
