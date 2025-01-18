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
        case sos = 2
        case chat = 3
    }

    @State var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("主页", systemImage: "house", value: .home){
                HomeView()
            }
            Tab("紧急救援", systemImage: "sos", value: .sos){
                SOSView()
            }
            Tab("客服", systemImage: "bubble.left.and.bubble.right", value: .chat){
                ChatView()
            }
        }
        .tint(Color(red: 1.0, green: 0.19, blue: 0.19))
    }
}


//struct RootView: View {
//    @State private var selectedTab: TabBarItem = TabBarItem(title: "Home", icon: "house")
//
//    let tabs: [TabBarItem] = [
//        TabBarItem(title: "主页", icon: "house"),
//        TabBarItem(title: "紧急救援", icon: "sos"),
//        TabBarItem(title: "客服", icon: "bubble.left.and.bubble.right")
//    ]
//
//    var body: some View {
//        NavigationView{
//            VStack {
//                Spacer()
//                switch selectedTab {
//                case tabs[0]:
//                    HomeView()
//                case tabs[1]:
//                    SOSView()
//                case tabs[2]:
//                    ChatView()
//                default:
//                    HomeView()
//                }
//                CustomTabBar(items: tabs, selectedItem: $selectedTab)
//            }
//        }
//    }
//}


#Preview {
    RootView()
}
