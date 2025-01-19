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
            // Shopping Channel
            VStack {
                Text("购物频道")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    AppIconView(imageName: "taobao", appName: "淘宝", urlScheme: "taobao://", appStoreLink: "https://apps.apple.com/cn/app/%E6%B7%98%E5%AE%9D-%E6%B7%98%E4%B8%AA%E5%A5%BD%E5%BD%A9%E5%A4%B4/id387682726")
                    AppIconView(imageName: "tmall", appName: "天猫", urlScheme: "tmall://", appStoreLink: "https://apps.apple.com/cn/app/%E5%A4%A9%E7%8C%AB-%E5%A5%BD%E5%93%81%E7%89%8C-%E5%A5%BD%E4%BB%B7%E6%A0%BC-%E4%B8%8A%E5%A4%A9%E7%8C%AB/id518966501")
                    AppIconView(imageName: "jingdong", appName: "京东", urlScheme: "openApp.jdMobile://", appStoreLink: "https://apps.apple.com/cn/app/%E4%BA%AC%E4%B8%9C-%E5%8F%88%E5%A5%BD%E5%8F%88%E4%BE%BF%E5%AE%9C/id414245413")
                }

                HStack(spacing: 30) {
                    AppIconView(imageName: "pinduoduo", appName: "拼多多", urlScheme: "pinduoduo://", appStoreLink: "https://apps.apple.com/cn/app/拼多多/id1020116749")
                    AppIconView(imageName: "douyin", appName: "抖音", urlScheme: "snssdk1128://", appStoreLink: "https://apps.apple.com/cn/app/抖音/id1142110895")
                }
            }

            Spacer()

            // Life Services Section
            VStack(spacing: 10) {
                Text("订餐、酒店、机票、网约车生活服务频道")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 30) {
                    AppIconView(imageName: "meituan", appName: "美团", urlScheme: "imeituan://", appStoreLink: "https://apps.apple.com/cn/app/美团/id372198446")
                    AppIconView(imageName: "ctrip", appName: "携程", urlScheme: "CtripWireless://", appStoreLink: "https://apps.apple.com/cn/app/携程旅行/id453392081")
                    AppIconView(imageName: "caocao", appName: "曹操出行", urlScheme: "open.caocaokej://", appStoreLink: "https://apps.apple.com/cn/app/曹操出行/id957687723")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("荣菩生活")
    }
    
    // Reusable app icon view
    struct AppIconView: View {
        var imageName: String
        var appName: String
        var urlScheme: String
        var appStoreLink: String
        
        var body: some View {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12) // Set consistent corner radius for all images
                    .onTapGesture {
                        openApp(urlScheme: urlScheme, appStoreLink: appStoreLink)
                    }
                Text(appName)
                    .font(.system(size: 16))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        func openApp(urlScheme: String, appStoreLink: String) {
            if let url = URL(string: urlScheme) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    if let appStoreURL = URL(string: appStoreLink) {
                        UIApplication.shared.open(appStoreURL)
                    }
                }
            }
        }
    }
}

#Preview {
    ShopView()
}
