//
//  CognitiveStateManaging.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//

import SwiftUI
import Combine

public protocol CognitiveStateManaging: AnyObject, ObservableObject {
    var score: Double { get set }
    var isFoveatedReadingActive: Bool { get set }
    var currentMode: CLOEMode { get }
}
