//
//  UserData.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/3/24.
//

import Combine
import Foundation

class UserData: ObservableObject {
    @Published var users: [UserInfoModel] = [
        UserInfoModel(
            id: UUID(),
            name: "张三",
            code: "001",
            DoB: Calendar.current.date(from: DateComponents(year: 1960, month: 1, day: 1))!,
            age: 60,
            gender: "男",
            image: "OldManImage",
            location: Location(province: "海南", city: "海口"),
            memberID: "Z123",
            emergencyContacts: ["李四", "王五"],
            medicalAccount: "123",
            socialSecurityAccount: "123",
            memberType: "VIP",
            joinDate: Calendar.current.date(from: DateComponents(year: 2020, month: 8, day: 1))!,
            heartRate: 75,
            bloodPressure: 120,
            bloodSugar: 90,
            cholesterol: 180,
            bloodOxygen: 95,
            ecgData: HealthMetricsModel.generateSampleECGData()
        )
    ]
}

