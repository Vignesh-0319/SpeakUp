//
//  ScenarioDetailView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct ScenarioDetailView: View {
    let scenario: Scenario

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: scenario.iconName)
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text(scenario.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(scenario.description)
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button("Start Practice") {
                // Action to navigate to the conversation practice for this scenario.
                // We will implement this navigation later.
                print("Starting practice for \(scenario.title)...")
            }
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
            .padding()
        }
        .navigationTitle(scenario.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // We wrap the preview in a NavigationStack to see the title correctly.
    NavigationStack {
        ScenarioDetailView(scenario: sampleScenarios[0])
    }
}

