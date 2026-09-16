//
//  ConfidenceChartView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI
import SwiftData
import Charts

struct ConfidenceChartView: View {
    @Query(sort: \ConfidenceScore.date) private var scores: [ConfidenceScore]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Progress")
                .font(.headline)
                .padding(.horizontal)

            Chart(scores) { score in
                // Create a line connecting the data points
                LineMark(
                    x: .value("Date", score.date, unit: .day),
                    y: .value("Score", score.score)
                )
                .foregroundStyle(.blue)
                .interpolationMethod(.catmullRom) // Makes the line smooth and curved

                // Add a symbol (dot) for each data point
                PointMark(
                    x: .value("Date", score.date, unit: .day),
                    y: .value("Score", score.score)
                )
                .foregroundStyle(.blue)
                .symbolSize(80)
            }
            .chartYScale(domain: 0...1) // Sets the Y-axis range from 0.0 to 1.0
            .frame(height: 200)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ConfidenceChartView()
        .modelContainer(for: ConfidenceScore.self, inMemory: true)
}

