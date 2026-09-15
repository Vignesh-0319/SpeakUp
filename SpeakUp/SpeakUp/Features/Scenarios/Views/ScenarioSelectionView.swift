//
//  ScenarioSelectionView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct ScenarioSelectionView: View {
    // Defines the columns for the grid. Two columns that adapt to screen size.
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // The array of scenarios to display, which we defined in Scenario.swift.
    let scenarios: [Scenario] = sampleScenarios

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(scenarios) { scenario in
                        // Each card is a navigation link to its detail view.
                        NavigationLink(value: scenario) {
                            CardView {
                                VStack(alignment: .leading, spacing: 16) {
                                    Image(systemName: scenario.iconName)
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(scenario.title)
                                            .font(.headline)
                                            .lineLimit(1)

                                        Text(scenario.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes the default blue styling from the link.
                    }
                }
                .padding()
            }
            .navigationTitle("Select a Scenario")
            .navigationDestination(for: Scenario.self) { scenario in
                // This defines where the NavigationLink will go.
                ScenarioDetailView(scenario: scenario)
            }
        }
    }
}

#Preview {
    ScenarioSelectionView()
}

