//
//  Message.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/13/25.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromCurrentUser: Bool
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(text: "Hi there!", isFromCurrentUser: false),
        Message(text: "Hello! How are you?", isFromCurrentUser: true)
    ]
    
    func sendMessage(_ text: String) {
        let newMessage = Message(text: text, isFromCurrentUser: true)
        messages.append(newMessage)
    }
}

