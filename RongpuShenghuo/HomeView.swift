//
//  HomeView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        NavigationLink(destination: HealthView()){
                            CustomButtonStyle(title: "健康管理", color: .blue)
                        }
                        
                        NavigationLink(destination: Text("placeholder")){
                            CustomButtonStyle(title: "设备管理", color: .green)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        NavigationLink(destination: ProfileView()){
                            CustomButtonStyle(title: "个人中心", color: .orange)
                        }
                        
                        NavigationLink(destination: ShopView()){
                            CustomButtonStyle(title: "生活频道", color: .purple)
                        }
                    }
                }
                
                Spacer()
                
                // Advertising section at the bottom
                VStack {
                    Image("salePoster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 480, alignment: .top)
                        .clipped()
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct CustomButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 70)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 3)
        }
    }
}

struct CustomButtonStyle: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.title)
            .frame(maxWidth: .infinity, minHeight: 70)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    HomeView()
}
