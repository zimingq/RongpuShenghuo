//
//  ChatView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/13/25.
//

import SwiftUI


extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText = ""

    var body: some View {
        VStack {
            // Message List
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.isFromCurrentUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 15)
                            .id(message.id)
                        }
                    }
                }
                .gesture(
                    DragGesture().onChanged { _ in
                        UIApplication.shared.dismissKeyboard()
                    }
                )
                .onChange(of: viewModel.messages) { _ in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // Input Field
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    viewModel.sendMessage(inputText)
                    inputText = ""
                }) {
                    Text("发送")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(inputText.isEmpty ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(inputText.isEmpty) // Disable button when inputText is empty
            }
        }
        .navigationTitle("客服")
        .padding() // Optional padding for better layout on different devices
    }
}


#Preview {
    NavigationStack { // Use NavigationStack to display navigationTitle
        ChatView()
    }
}
