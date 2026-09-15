//
//  DashboardView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // --- Header ---
                    VStack(alignment: .leading) {
                        Text("Good Morning! 👋")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Ready to SpeakUp?")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // --- Confidence Chart ---
                    ConfidenceChartView()
                    
                    // --- Start Speaking Button ---
                    Button(action: {
                        // This will eventually navigate to the practice screen
                        print("Start Speaking Tapped")
                    }) {
                        Text("🎙️ Start Speaking")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Dashboard")
            .toolbar {
                // --- Add Score Button (for testing) ---
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Score") {
                        addRandomScore()
                    }
                }
            }
        }
    }
    
    // --- Function to add a random score for testing the chart ---
    private func addRandomScore() {
        // Adds a new score for a random day in the past month with a random value
        let randomDay = Calendar.current.date(byAdding: .day, value: .random(in: -30...0), to: .now)!
        let newScore = ConfidenceScore(date: randomDay, score: Double.random(in: 0.4...0.9))
        modelContext.insert(newScore)
        print("Added new score: \(newScore.score) on \(newScore.date.formatted(date: .numeric, time: .omitted))")

    }
}

#Preview {
    DashboardView()
        .modelContainer(for: ConfidenceScore.self, inMemory: true)
}

