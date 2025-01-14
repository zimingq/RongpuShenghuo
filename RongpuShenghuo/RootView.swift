//
//  HomeView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct RootView: View {
    enum Tabs: Int{
        case home = 1
        case chat = 2
        case sos = 3
        case profile = 4
    }

    @State var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("主页", systemImage: "house", value: .home){
                HomeView()
            }
            Tab("客服", systemImage: "bubble.left.and.bubble.right", value: .home){
                ChatView()
            }
            Tab("紧急救援", systemImage: "sos", value: .sos){
                SOSView()
            }
            Tab("我", systemImage: "person", value: .profile){
                ProfileView()
            }
        }
        .tint(Color(red: 1.0, green: 0.19, blue: 0.19))
    }
}

#Preview {
    RootView()
}
