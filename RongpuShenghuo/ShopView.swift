//
//  ShopView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Shopping Channel Section
            VStack(spacing: 10) {
                Text("购物频道")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    VStack {
                        Image("taobao")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                        Text("淘宝")
                            .font(.body)
                    }

                    VStack {
                        Image("jingdong")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                        Text("京东")
                            .font(.body)
                    }

                    VStack {
                        Image("pinduoduo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                        Text("拼多多")
                            .font(.body)
                    }
                }
            }

            Spacer()

            // Life Services Section
            VStack(spacing: 10) {
                Text("生活服务频道")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    VStack {
                        Image(systemName: "fork.knife") // Placeholder for 美团
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.orange)
                            .padding() // Add padding inside the border
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.orange, lineWidth: 2) // Border with orange color
                            )
                        Text("美团")
                            .font(.body)
                    }

                    VStack {
                        Image(systemName: "house.fill") // Placeholder for 养老院
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.purple)
                            .padding() // Add padding inside the border
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.purple, lineWidth: 2) // Border with purple color
                            )
                        Text("养老院")
                            .font(.body)
                    }

                    VStack {
                        Image(systemName: "airplane") // Placeholder for 旅游
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.cyan)
                            .padding() // Add padding inside the border
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.cyan, lineWidth: 2) // Border with cyan color
                            )
                        Text("旅游")
                            .font(.body)
                    }
                }

            }

            Spacer()
        }
        .padding()
        .navigationTitle("商城")
    }
}

#Preview {
    ShopView()
}
