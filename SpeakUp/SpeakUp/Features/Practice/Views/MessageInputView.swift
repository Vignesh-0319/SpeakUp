//
//  MessageInputView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct MessageInputView: View {
    @Binding var text: String
    let onSend: () -> Void

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            // --- Text Field ---
            TextField("Type your message...", text: $text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...5) // Allows the text field to grow up to 5 lines

            // --- Send Button ---
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.largeTitle)
            }
            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .background(.thinMaterial) // A semi-transparent background
    }
}

#Preview {
    // We use a .constant binding for the preview
    MessageInputView(text: .constant("This is a test message")) {
        print("Send button tapped")
    }
}

