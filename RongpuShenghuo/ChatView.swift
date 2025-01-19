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
    
    func showKeyboard() {
        sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText = ""
    @FocusState private var textFieldFocusState
    @Binding var selectedTab: RootView.Tabs
    
    var body: some View {
        NavigationView {
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
                    .onChange(of: viewModel.messages) { _ in
                        if let lastMessage = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                HStack {
                    Button {
                        print("voice called")
                    } label: {
                        Image(systemName: "waveform")
                    }

                    TextField("", text: $inputText)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 5)
                        .submitLabel(.send)
                        .focused($textFieldFocusState)
                        .onSubmit {
                            textFieldFocusState = true
                            if inputText.isEmpty {
                                return
                            } else {
                                sendMessage()
                                UIApplication.shared.showKeyboard()  // Show keyboard again after submission
                            }
                        }

                    // Action Menu (Optional, depending on your UI)
                    Menu {
                        Button(action: {
                            // Add action for phone call here
                            print("Phone call selected")
                        }) {
                            Label("语音通话", systemImage: "phone.fill")
                        }
                        Button(action: {
                            // Add action for video call here
                            print("Video call selected")
                        }) {
                            Label("视频通话", systemImage: "video.fill")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                    }
                }
            }
            .navigationTitle("客服")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    // Add action for back button
                    selectedTab = .home
                }) {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Back")
                            .font(.headline)
                    }
                },
                trailing: NavigationLink(
                        destination: NotificationView()
                    ) {
                        Image(systemName: "bell.fill")
                            .font(.headline)
                    }
            )
            .padding()
        }
    }

    private func sendMessage() {
        if !inputText.isEmpty {
            viewModel.sendMessage(inputText)
            inputText = ""  // Clear the input text after sending
            // No need to dismiss the keyboard here
        }
    }
}


#Preview {
    ChatView(selectedTab: .constant(.chat))
}
