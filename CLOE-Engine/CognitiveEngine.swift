//
//  CognitiveEngine.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/06/2026.
//

import Foundation
import Combine

enum CLOE_Mode: String, CaseIterable {
    case deepWork = "Deep Work"
    case declutter = "Declutter"
    case hyperMinimal = "Hyper-Minimal"
    case neuralReset = "Neural Reset"
}



final class CognitiveEngine: ObservableObject {
    // Fatigue score from 0.0 (energized) to 1 (tired)
    
    @Published var score: Double = 0.0
    
    
    var currentMode: CLOE_Mode {
        switch score {
        case 0.0..<0.35: return .deepWork
        case 0.35..<0.70: return .declutter
        case 0.70..<0.9: return .hyperMinimal
        default: return .neuralReset
        }
    }
}
