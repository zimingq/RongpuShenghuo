//
//  HomeView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct RootView: View {
    
    enum Tabs: Int {
        case home = 1
        case sos = 2
        case chat = 3
    }

    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Text("主页")
                    Image(systemName: "house.fill")
                }
                .tag(Tabs.home)
            
            SOSView()
                .tabItem {
                    Text("疾速救援")
                    Image(systemName: "sos")
                }
                .tag(Tabs.sos)
            
            ChatView(selectedTab: $selectedTab)
                .tabItem {
                    Text("客服")
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                }
                .tag(Tabs.chat)
        }
    }
}

#Preview {
    RootView()
}
