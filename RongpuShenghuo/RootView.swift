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
        case shop = 2
        case sos = 3
        case health = 4
        case profile = 5
    }

    @State var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("主页", systemImage: "house", value: .home){
                HomeView()
            }
            Tab("荣菩生活", systemImage: "person.2", value: .shop){
                ShopView()
            }
            Tab("紧急救援", systemImage: "sos", value: .sos){
                SOSView()
            }
            Tab("智能监测", systemImage: "waveform.path.ecg", value: .health){
                HealthView()
            }
            Tab("我", systemImage: "person", value: .profile){
                ProfileView()
            }
        }
    }
}

#Preview {
    RootView()
}
