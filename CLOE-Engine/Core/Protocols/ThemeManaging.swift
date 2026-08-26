//
//  ThemeManaging.swift
//  CLOE-Engine
//
//  Created by Ioana Ghinet on 24/08/2026.
//
import SwiftUI
import Combine

public protocol ThemeManaging: AnyObject, ObservableObject {
    var selectedTheme: AppTheme { get set }
    func effectiveBackgroundColor(for score: Double) -> Color
    func effectiveTextColor(for score: Double) -> Color
}

