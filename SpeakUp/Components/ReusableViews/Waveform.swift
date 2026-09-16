//
//  Waveform.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct Waveform: Shape {
    var amplitudes: [Float]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the horizontal distance between each point
        let step = rect.width / CGFloat(amplitudes.count - 1)
        
        // Move to the first point
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        
        // Loop through the amplitudes and draw lines
        for i in 0..<amplitudes.count {
            let x = CGFloat(i) * step
            
            // Normalize the amplitude to the view's height
            // We multiply by a factor (e.g., 200) to make the waveform more visible
            let normalizedAmplitude = CGFloat(amplitudes[i]) * (rect.height / 2) * 200
            
            let y = (rect.height / 2) - normalizedAmplitude
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}

