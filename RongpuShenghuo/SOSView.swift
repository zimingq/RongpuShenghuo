//
//  SOSView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct SOSView: View {
    @State private var selectedOption = "迷路救助" // State to track the selected option
    @State private var isModalVisible = false // Toggle for modal visibility
    let options = ["迷路救助", "生命救助"] // Picker options

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Title Section
                VStack(spacing: 10) {
                    Image("SOS")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                    
                    Text("选择您需要的救助类型，并获取相应帮助")
                        .font(.system(size: 18)) // Custom font size
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Description Section
                VStack(alignment: .leading, spacing: 10) {
                    Text(shortDescription)
                        .font(.system(size: 16)) // Custom font size
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    Button(action: {
                        isModalVisible.toggle()
                    }) {
                        Text("展开详细信息")
                            .font(.system(size: 16)) // Custom font size
                            .foregroundColor(.blue)
                    }
                }

                VStack(spacing: 20) {
                    Text("生命救助")
                        .font(.system(size: 20)) // Custom font size

                    HStack(spacing: 16) {
                        // Buttons
                        ActionButton(title: "语音", color: .blue, iconName: "mic.fill")
                        ActionButton(title: "视频", color: .green, iconName: "video.fill")
                        ActionButton(title: "一键求助", color: .red, iconName: "exclamationmark.triangle.fill")
                    }
                }
                
                // Actions Section
                VStack(spacing: 20) {
                    Text("迷路救助")
                        .font(.system(size: 20)) // Custom font size

                    HStack(spacing: 16) {
                        // Buttons
                        ActionButton(title: "语音", color: .blue, iconName: "mic.fill")
                        ActionButton(title: "视频", color: .green, iconName: "video.fill")
                        ActionButton(title: "一键求助", color: .red, iconName: "exclamationmark.triangle.fill")
                    }
                }

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("SOS 救援")
                        .font(.system(size: 20)) // Custom font size
                        .bold()
                }
            }
            .sheet(isPresented: $isModalVisible) {
                FullDescriptionView(isModalVisible: $isModalVisible)
            }
        }
    }

    // Short Description
    private var shortDescription: String {
        """
        SOS救援共分三档：
        1. 迷路救助服务 - 全天候、全方位伴您出行，为会员提供迷路帮助。
        2. 意外情况救助服务 - 当会员意外跌倒失能、交通事故危及生命时，系统实时联动120及时施救。
        3. 生命安全救助服务 - 心脑血管疾病突发危及生命安全时，系统实时联动120及时施救。
        """
    }
}

// Modal for Full Description
struct FullDescriptionView: View {
    @Binding var isModalVisible: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Text("详细说明")
                            .font(.system(size: 24))
                            .bold()
                        Spacer()
                        Button("购买会员"){
                            
                        }
                        .frame(width: 100)
                        .padding()
                        .tint(.red)
                    }
                    Text(fullDescription)
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
            .navigationTitle("详细信息")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        isModalVisible = false
                    }
                }
            }
        }
    }

    // Full Description
    private var fullDescription: String {
        """
        一、SOS救援会员共分三档：
        1. 迷路救助服务 - 全天候、全方位伴您出行，为会员提供迷路帮助（包括会员主动求助和守护系统根据位移轨迹研判会员迷路系统介入帮助）。
        2. 意外情况救助服务 - 当会员意外跌倒失能、交通事故危及生命时，系统实时联动120及时施救，力争您在黄金救援时限内得到救援。
        3. 生命安全救助服务 - 心脑血管疾病突发危及生命安全时，系统实时联动120及时施救，力争您在黄金救援时限内得到救援。

        二、会员收费标准，共分三档：
        1. 迷路救助服务：20元/季度/人；35元/半年/人；60元/年/人。
        2. 意外情况救助服务（赠送迷路救助服务）：30元/季度/人；50元/半年/人；80元/年/人。
        3. 生命安全救助服务（赠送迷路救助服务和意外情况救助服务）：80元/季度/人；120元/半年/人；190元/年/人。
        """
    }
}

// Custom ActionButton Component
struct ActionButton: View {
    let title: String
    let color: Color
    let iconName: String  // Added to pass icon name

    var body: some View {
        Button(action: {
            // Action goes here
        }) {
            HStack {
                Image(systemName: iconName) // Icon for the button
                    .foregroundColor(.white)
                Text(title)
                    .font(.system(size: 18)) // Custom font size
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            .background(color)
            .cornerRadius(12)
        }
    }
}


#Preview {
    SOSView()
}
