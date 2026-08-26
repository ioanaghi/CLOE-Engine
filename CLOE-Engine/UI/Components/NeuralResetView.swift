//
//  NeuralResetView.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI

public struct NeuralResetView: View {
    let score: Double
    
    public var body: some View {
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
    }
}
