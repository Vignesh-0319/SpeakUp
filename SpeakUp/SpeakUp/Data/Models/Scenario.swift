//
//  Scenario.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import Foundation

// Defines the structure for a single conversation scenario.
struct Scenario: Identifiable, Hashable {
    let id = UUID() // Provides a unique ID for each scenario.
    let title: String
    let iconName: String
    let description: String
}

// An array of sample scenarios to display in our selection screen.
// In a real app, this might be fetched from a server.
let sampleScenarios: [Scenario] = [
    Scenario(title: "College", iconName: "graduationcap.fill", description: "Practice conversations for university life."),
    Scenario(title: "Job Interview", iconName: "briefcase.fill", description: "Prepare for professional interviews."),
    Scenario(title: "Ordering Food", iconName: "fork.knife", description: "Practice ordering at a restaurant."),
    Scenario(title: "Everyday Life", iconName: "house.fill", description: "Common daily conversations."),
    Scenario(title: "Travel", iconName: "airplane", description: "Scenarios for traveling and exploring."),
    Scenario(title: "Social Events", iconName: "person.2.fill", description: "Engage in conversations at social gatherings.")
]

