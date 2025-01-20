//
//  UserManager.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/7/24.
//

import Foundation
import Combine

class UserInfoManager: ObservableObject {
    @Published var users: [UserInfoModel] = []
    
    init() {
        // Load saved user info or initialize with default values
        if let data = UserDefaults.standard.data(forKey: "savedUserInfo"),
           let savedUsers = try? JSONDecoder().decode([UserInfoModel].self, from: data) {
            users = savedUsers
        } else {
            // Initialize with example users
            users = [
                UserInfoModel(
                    id: UUID(),
                    name: "张三",
                    code: "123456",
                    DoB: Calendar.current.date(from: DateComponents(year: 1969, month: 10, day: 5)) ?? Date(),
                    age: 55,
                    gender: "男",
                    image: "profilePicMan",
                    location: Location(province: "海南", city: "海口"),
                    memberID: "SMJY320321197008063036",
                    emergencyContacts: ["李四 1301231234", "王五 1301231234"],
                    medicalAccount: "123456789",
                    socialSecurityAccount: "123456789",
                    memberType: "生命救援",
                    joinDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 5)) ?? Date(),
                    heartRate: 75,
                    bloodPressure: 120,
                    bloodSugar: 90,
                    cholesterol: 180,
                    bloodOxygen: 95,
                    ecgData: HealthMetricsModel.generateSampleECGData()
                )
            ]
        }
    }
    
    func addUser(_ user: UserInfoModel) {
        users.append(user)
        saveUserInfo()
    }
    
    func saveUserInfo() {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: "savedUserInfo")
        }
    }
}
