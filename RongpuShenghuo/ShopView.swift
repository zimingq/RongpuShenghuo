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
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    VStack {
                        Image("taobao")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                        Text("淘宝")
                            .font(.system(size: 16))
                    }
                    
                    VStack {
                        Image("tmall")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("天猫")
                            .font(.system(size: 16))
                    }
                    
                    VStack {
                        Image("jingdong")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                        Text("京东")
                            .font(.system(size: 16))
                    }

                }
                
                HStack(spacing: 30) {
                    VStack {
                        Image("pinduoduo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("拼多多")
                            .font(.system(size: 16))
                    }
                    .frame(alignment: .leading)
                    
                    VStack {
                        Image("douyin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("抖音")
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 35)
            }

            Spacer()

            // Life Services Section
            VStack(spacing: 10) {
                Text("订餐、酒店、机票、网约车生活服务频道")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    VStack {
                        Image("meituan")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("美团")
                            .font(.system(size: 16))
                    }


                    VStack {
                        Image("ctrip")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("携程")
                            .font(.system(size: 16))
                    }
                    
                    VStack {
                        Image("caocao")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("曹操出行")
                            .font(.system(size: 16))
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
                            .font(.system(size: 16))
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
