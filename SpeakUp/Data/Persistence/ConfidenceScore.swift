//
//  ConfidenceScore.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import Foundation
import SwiftData

@Model
final class ConfidenceScore {
    var date: Date
    var score: Double // A score from 0.0 to 1.0 for the chart

    init(date: Date, score: Double) {
        self.date = date
        self.score = score
    }
}

