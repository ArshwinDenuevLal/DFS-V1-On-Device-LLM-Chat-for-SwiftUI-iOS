//
//  ChatView.swift
//  DFSVOneChat
//
//  Created by Admin on 13/09/25.
//


import SwiftUI

struct ChatView: View {
    @StateObject private var modelManager = ModelManager()
    @State private var userInput: String = ""
    @State private var messages: [Message] = []

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { message in
                    MessageView(message: message)
                }
            }

            HStack {
                TextField("Type a message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: sendMessage) {
                    Text("Send")
                }
                .padding()
            }
        }
        .padding()
    }

    func sendMessage() {
        let userMessage = Message(text: userInput, isUser: true)
        messages.append(userMessage)

        modelManager.generateResponse(prompt: userInput)
        let botMessage = Message(text: modelManager.response, isUser: false)
        messages.append(botMessage)

        userInput = ""
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}