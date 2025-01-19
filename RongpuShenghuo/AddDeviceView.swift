//
//  AddDeviceView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/19/25.
//

import SwiftUI

struct AddDeviceView: View {
    @State private var deviceName: String = ""
    @State private var deviceDescription: String = "请输入设备描述"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Device grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    // Example device: Smart Watch
                    DeviceBlock(imageName: "applewatch", deviceName: "智能手表")
                }
                .padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action to add device
                        addDevice()
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                    Button(action: {
                        // Reset form or delete device logic
                        resetForm()
                    }) {
                        Image(systemName: "trash")
                            .font(.title2)
                    }
                }
            }
        }
    }
    
    private func resetForm() {
    }
    
    private func addDevice() {
    }
}

struct DeviceBlock: View {
    var imageName: String
    var deviceName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(12)
            
            Text(deviceName)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    AddDeviceView()
}

