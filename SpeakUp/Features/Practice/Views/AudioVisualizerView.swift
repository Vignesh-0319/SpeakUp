//
//  AudioVisualizerView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct AudioVisualizerView: View {
    @StateObject private var visualizer = AudioVisualizer()
    
    var body: some View {
        VStack {
            Waveform(amplitudes: visualizer.amplitudes)
                .stroke(Color.blue, lineWidth: 2)
                .frame(height: 80)
                .padding(.horizontal)
        }
        .onAppear {
            visualizer.requestPermission()
            visualizer.startMonitoring()
        }
        .onDisappear {
            visualizer.stopMonitoring()
        }
    }
}

#Preview {
    AudioVisualizerView()
        .background(Color.black.opacity(0.8))
}

