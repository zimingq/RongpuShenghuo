//
//  SOSView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/11/25.
//

import SwiftUI

struct SOSView: View {
    @State private var selectedOption = "迷路救助" // State to track the selected option
    let options = ["迷路救助", "生命救助"] // Picker options

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Picker Section
                VStack(spacing: 16) {
                    Text("选择救助类型")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    Picker(selection: $selectedOption, label: Text("救助类型")) {
                        ForEach(options, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Use a segmented picker style
                    .padding()
                }

                // Additional Buttons Section
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 18) // Rounded corners
                        .fill(Color.blue) // Button color
                        .frame(height: 80)
                        .overlay(Text("语音")
                            .foregroundColor(.white)
                            .font(.title)) // Button label

                    RoundedRectangle(cornerRadius: 18) // Rounded corners
                        .fill(Color.green) // Button color
                        .frame(height: 80)
                        .overlay(Text("视频")
                            .foregroundColor(.white)
                            .font(.title)) // Button label

                    RoundedRectangle(cornerRadius: 18) // Rounded corners
                        .fill(Color.green) // Button color
                        .frame(height: 80)
                        .overlay(Text("一键求助")
                            .foregroundColor(.white)
                            .font(.title)) // Button label
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("SOS 救援")
                        .font(.system(size: 22))
                        .bold()
                }
            }
        }
    }
}

#Preview {
    SOSView()
}
