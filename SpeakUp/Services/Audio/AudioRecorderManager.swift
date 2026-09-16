//
//  AudioRecorderManager.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import Foundation
import AVFoundation
import Combine // <-- ADD THIS LINE

class AudioRecorderManager: NSObject, ObservableObject, AVAudioRecorderDelegate {
    @Published var isRecording = false
    
    private var audioRecorder: AVAudioRecorder?
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    // The rest of the file remains exactly the same...
    
    func startRecording() {
        // 1. Set up the audio session
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
            return
        }
        
        // 2. Define the path for the audio file
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(UUID().uuidString).m4a")

        // 3. Define the recorder settings
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        // 4. Create and start the recorder
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
            print("Recording started. Saving to: \(audioFilename)")
        } catch {
            print("Could not start recording: \(error.localizedDescription)")
            isRecording = false
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        print("Recording stopped.")
        
        do {
            try audioSession.setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
    
    // --- AVAudioRecorderDelegate ---
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Finished recording successfully. File is at: \(recorder.url)")
            // Here you would handle the finished audio file,
            // e.g., send it to a speech-to-text API.
        } else {
            print("Recording failed.")
        }
    }
}
