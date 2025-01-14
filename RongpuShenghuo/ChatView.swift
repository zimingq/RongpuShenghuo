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
                Button(action: {
                    // Add action for the phone icon button if needed
                }) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    // Add action for the video icon button if needed
                }) {
                    Image(systemName: "video.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }

                TextField("", text: $inputText)
                    .padding(10) // Add padding inside the text field
                    .background(Color.white)
                    .cornerRadius(16) // Make the corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal,5)

                Button(action: {
                    viewModel.sendMessage(inputText)
                    inputText = ""
                }) {
                    Text("发送")
                        .font(.system(size: 20)) // Make the text bigger
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(inputText.isEmpty ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
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
