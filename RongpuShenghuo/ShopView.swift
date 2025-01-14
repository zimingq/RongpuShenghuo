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
                        Image("tmall")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("天猫")
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

                }
                
                HStack(spacing: 30) {
                    VStack {
                        Image("pinduoduo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("拼多多")
                            .font(.body)
                    }
                    .frame(alignment: .leading)
                    
                    VStack {
                        Image("douyin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("抖音")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 35)
            }

            Spacer()

            // Life Services Section
            VStack(spacing: 10) {
                Text("订餐、酒店、机票、网约车生活服务频道")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    VStack {
                        Image("meituan")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("美团")
                            .font(.body)
                    }


                    VStack {
                        Image("ctrip")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("携程")
                            .font(.body)
                    }
                    
                    VStack {
                        Image("caocao")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("曹操出行")
                            .font(.body)
                    }
                }
                
                HStack {
                    VStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.purple)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.purple, lineWidth: 2)
                            )
                        Text("养老院")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 35)

            }

            Spacer()
        }
        .padding()
        .navigationTitle("荣菩生活")
    }
}

#Preview {
    ShopView()
}
