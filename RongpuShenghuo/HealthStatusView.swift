//
//  HealthIndicatorView.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/26/25.
//

import SwiftUI

struct HealthStatusView: View {
    @State private var healthStatus = Array(repeating: 0, count: 60)
    @State private var currentIndex = 0
    @State private var healthValue = 50
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                HealthStatusIndicator(healthStatus: healthStatus)
                
                // Use the calculated health value for the indicator bar
                HealthProgressBar(healthValue: healthValue)
            }
            .onReceive(timer) { _ in
                if currentIndex < healthStatus.count {
                    healthStatus[currentIndex] = weightedRandom()
                    currentIndex += 1
                } else if currentIndex == 60 {
                    healthStatus = Array(repeating: 0, count: 60)
                    currentIndex = 0
                }
                
                // Calculate health value and animate the change
                withAnimation(.easeInOut(duration: 0.5)) {
                    healthValue = calculateHealthValue()
                }
            }
            .border(.black, width: 2)
            HStack {
                Text("0")
                Spacer()
                Text("1分钟")
            }
            .padding(.horizontal, 40)
            Text("注：右侧为健康等级提示条")
            
        }
        .border(Color.black, width: 2)
        .padding()
        Text("RP矩阵")
            .font(.title)
    }
    
    func calculateHealthValue() -> Int {
        let nonZeroValues = healthStatus.filter { $0 > 0 }
        let totalWeight = nonZeroValues.reduce(0, +)
        let count = nonZeroValues.count
        return count > 0 ? Int(Double(totalWeight) / Double(count) * 20) : 0
    }
    
    func weightedRandom() -> Int {
        let randomValue = Int.random(in: 1...10)
        switch randomValue {
        case 1...5:
            return 5
        case 6...7:
            return 4
        case 8:
            return 3
        case 9:
            return 2
        default:
            return 1
        }
    }
}

struct HealthStatusIndicator: View {
    var healthStatus: [Int]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("危险")
                    .padding(.horizontal, 5)
                HealthStatusSection(rowColor: .red, healthStatus: healthStatus, healthIndicator: 1)
            }
            .border(Color.black, width: 1)
            HStack(spacing: 0) {
                Text("亚三")
                    .padding(.horizontal, 5)
                HealthStatusSection(rowColor: .pink, healthStatus: healthStatus, healthIndicator: 2)
            }
            .border(Color.black, width: 1)
            HStack(spacing: 0) {
                Text("亚二")
                    .padding(.horizontal, 5)
                HealthStatusSection(rowColor: .orange, healthStatus: healthStatus, healthIndicator: 3)
            }
            .border(Color.black, width: 1)
            HStack(spacing: 0) {
                Text("亚一")
                    .padding(.horizontal, 5)
                HealthStatusSection(rowColor: .yellow, healthStatus: healthStatus, healthIndicator: 4)
            }
            .border(Color.black, width: 1)
            HStack(spacing: 0) {
                Text("健康")
                    .padding(.horizontal, 5)
                HealthStatusSection(rowColor: .green, healthStatus: healthStatus, healthIndicator: 5)
            }
            .border(Color.black, width: 1)
        }
    }
}

struct HealthStatusSection: View {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 60)
    
    let numRows = 6
    let numColumns = 60
    
    var rowColor: Color
    var healthStatus: [Int]
    var healthIndicator: Int
    
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(0..<numRows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<numColumns, id: \.self) { column in
                        Rectangle()
                            .fill(
                                (healthStatus[column] == healthIndicator && (row == 2 || row == 3)) ? .black : rowColor
                            )
                            .frame(height: 10)
                            .border(Color.black, width: 1)
                    }
                }
            }
        }
    }
}

struct HealthProgressBar: View {
    let healthValue: Int
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .green]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 40, height: 300)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
                VStack(spacing: 0) {
                    ForEach(0..<5) { row in
                        Rectangle()
                            .fill(.black.opacity(0))
                            .frame(width: 40, height: 60)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: ((healthValue / 20) == row) ? 5 : 1)
                            )
                    }
                }
            }
        }
        .frame(width: 40, height: 300)
    }
    
    private func calculateOffset(for value: Int) -> CGFloat {
        let barHeight: CGFloat = 260
        let range: CGFloat = 100
        let normalizedValue = CGFloat(value) / range
        let offset = (normalizedValue * barHeight) - (barHeight / 2)
        return offset
    }
}

#Preview {
    HealthStatusView()
}
