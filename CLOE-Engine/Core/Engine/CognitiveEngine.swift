//
//  CognitiveEngine.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/07/2026.
//

import Foundation
import Combine

public final class CognitiveEngine: ObservableObject, CognitiveStateManaging {
    @Published public var score: Double = 0.0
    @Published public var isFoveatedReadingActive: Bool = false
    
    public init() {}
    
    public var currentMode: CLOEMode {
        switch score {
        case 0.0..<0.35: return .deepWork
        case 0.35..<0.70: return .declutter
        case 0.70..<0.90: return .hyperMinimal
        default: return .neuralReset
        }
    }
}
