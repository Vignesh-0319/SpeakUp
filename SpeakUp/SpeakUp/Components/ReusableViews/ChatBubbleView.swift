//
//  ChatBubbleView.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import SwiftUI

struct ChatBubbleView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer() // Pushes the bubble to the right for the user
            }

            Text(message.content)
                .padding(12)
                .background(message.isUser ? Color.blue : Color(.systemGray4))
                .foregroundColor(.white)
                .cornerRadius(16)
                .frame(maxWidth: 300, alignment: message.isUser ? .trailing : .leading)

            if !message.isUser {
                Spacer() // Pushes the bubble to the left for the AI
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 10) {
        ChatBubbleView(message: Message(content: "Hello! This is a message from the AI.", isUser: false))
        ChatBubbleView(message: Message(content: "Hi! This is a reply from the user. It might be a bit longer to check how wrapping works.", isUser: true))
    }
    .padding()
}

