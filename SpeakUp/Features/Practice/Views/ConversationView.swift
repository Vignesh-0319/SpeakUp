import SwiftUI

struct ConversationView: View {
    // --- State Properties ---
    @State private var messages: [Message] = [
        Message(content: "Hello! Tap the record button to start practicing.", isUser: false)
    ]
    @State private var userInput: String = ""
    private let bottomAnchorID = "bottomAnchor"
    
    // --- Audio Managers ---
    @StateObject private var recorderManager = AudioRecorderManager()

    var body: some View {
        VStack {
            // --- Message List ---
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }
                        Color.clear.frame(height: 1).id(bottomAnchorID)
                    }
                    .padding(.top)
                }
                .onChange(of: messages) {
                    withAnimation {
                        scrollView.scrollTo(bottomAnchorID, anchor: .bottom)
                    }
                }

            }
            
            // --- Input & Recording Area ---
            VStack {
                // Show the waveform only when recording
                if recorderManager.isRecording {
                    AudioVisualizerView()
                }
                
                HStack(spacing: 16) {
                    // The text input field
                    MessageInputView(text: $userInput) {
                        sendMessage()
                    }
                    
                    // The record button
                    Button(action: {
                        if recorderManager.isRecording {
                            recorderManager.stopRecording()
                        } else {
                            recorderManager.startRecording()
                        }
                    }) {
                        Image(systemName: recorderManager.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(recorderManager.isRecording ? .red : .blue)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .background(.thinMaterial)
        }
        .navigationTitle("Practice")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        messages.append(Message(content: userInput, isUser: true))
        let userMessage = userInput
        userInput = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let aiResponse = "You typed: \"\(userMessage)\". Try using the record button!"
            messages.append(Message(content: aiResponse, isUser: false))
        }
    }
}

#Preview {
    NavigationStack {
        ConversationView()
    }
}
