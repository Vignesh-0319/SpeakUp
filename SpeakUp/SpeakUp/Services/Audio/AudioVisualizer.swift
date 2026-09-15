import Foundation
import AVFoundation
import Accelerate
import Combine // <-- THE MISSING IMPORT

@MainActor
class AudioVisualizer: ObservableObject {
    @Published var amplitudes: [Float] = Array(repeating: 0.0, count: 50)
    
    private var audioEngine = AVAudioEngine()
    private var inputNode: AVAudioInputNode?
    
    // --- Permission ---
    func requestPermission() {
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                print("Microphone permission granted.")
            } else {
                print("Microphone permission denied.")
                // You should show an alert to the user here
            }
        }
    }
    
    // --- Monitoring ---
    func startMonitoring() {
        // 1. Get the input node from the audio engine
        inputNode = audioEngine.inputNode
        guard let inputNode = inputNode else {
            print("Audio engine has no input node.")
            return
        }
        
        // 2. Get the audio format
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        // 3. Install a "tap" on the input node to get live audio buffers
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, when) in
            guard let self = self else { return }
            
            // 4. Process the buffer to calculate amplitude
            let rms = self.processAudioBuffer(buffer)
            
            // 5. Update the published amplitudes array on the main thread
            DispatchQueue.main.async {
                self.updateAmplitudes(with: rms)
            }
        }

        // 6. Prepare and start the audio engine
        do {
            try audioEngine.start()
        } catch {
            print("Could not start audio engine: \(error)")
        }
    }

    func stopMonitoring() {
        audioEngine.stop()
        inputNode?.removeTap(onBus: 0)
    }
    
    // --- Private Helpers ---
    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData else { return 0 }
        let channelDataValue = channelData.pointee
        let channelDataValueArray = UnsafeBufferPointer(start: channelDataValue, count: Int(buffer.frameLength))
        
        // Calculate the Root Mean Square (RMS) of the audio buffer
        let rms = sqrt(channelDataValueArray.map { $0 * $0 }.reduce(0, +) / Float(buffer.frameLength))
        return rms
    }
    
    private func updateAmplitudes(with newAmplitude: Float) {
        // Shift old amplitudes to the left and add the new one
        amplitudes.removeFirst()
        amplitudes.append(newAmplitude)
    }
}
