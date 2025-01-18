//
//  CustomTabBar.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/15/25.
//

import SwiftUI

struct CustomTabBar: View {
    let items: [TabBarItem]
    @Binding var selectedItem: TabBarItem

    var body: some View {
        HStack {
            Spacer()
            ForEach(items, id: \.self) { item in
                VStack {
                    Image(systemName: item.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 30)
                    Text(item.title)
                        .font(.caption)
                }
                .padding(.horizontal)
                .foregroundColor(selectedItem == item ? .red : .gray)
                .onTapGesture {
                    selectedItem = item
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RootView()
}
