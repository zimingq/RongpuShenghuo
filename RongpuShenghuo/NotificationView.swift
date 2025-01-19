//
//  NotificationView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/19/25.
//

import SwiftUI

// Notification model
struct NotificationItem: Identifiable {
    let id = UUID()
    var title: String
    var isRead: Bool
}

// Notification View
struct NotificationView: View {
    @State private var notifications = [
        NotificationItem(title: "来自张三的消息", isRead: false),
        NotificationItem(title: "系统更新可用", isRead: true),
        NotificationItem(title: "提醒：下午3点的会议", isRead: false),
        NotificationItem(title: "您的帖子有新评论", isRead: true)
    ]
    
    @State private var selectedNotification: NotificationItem?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notifications) { notification in
                    HStack {
                        Text(notification.title)
                            .strikethrough(notification.isRead, color: .gray)
                            .foregroundColor(notification.isRead ? .gray : .black)
                        
                        Spacer()
                    }
                    .contentShape(Rectangle()) // To make the entire row tappable
                    .onTapGesture {
                        openNotification(notification)
                    }
                    .swipeActions {
                        // Swipe actions: Delete
                        Button(role: .destructive) {
                            deleteNotification(notification)
                        } label: {
                            Label("删除", systemImage: "trash.fill")
                        }
                    }
                }
            }
            .navigationTitle("通知")
            .alert(item: $selectedNotification) { notification in
                Alert(
                    title: Text(notification.title),
                    message: Text("这是通知的详细信息。"),
                    dismissButton: .default(Text("关闭"))
                )
            }
        }
    }
    
    // Open notification
    func openNotification(_ notification: NotificationItem) {
        selectedNotification = notification
    }
    
    // Delete notification
    func deleteNotification(_ notification: NotificationItem) {
        notifications.removeAll { $0.id == notification.id }
    }
}

#Preview {
    NotificationView()
}
