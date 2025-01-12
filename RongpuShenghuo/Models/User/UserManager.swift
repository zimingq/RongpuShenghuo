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
                    memberID: "Z320321197008063036",
                    emergencyContacts: ["李四 1301231234", "王五 1301231234"],
                    medicalAccount: "123456789",
                    socialSecurityAccount: "123456789",
                    memberType: "智能会员",
                    joinDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 5)) ?? Date(),
                    heartRate: 75,
                    bloodPressure: 120,
                    bloodSugar: 90,
                    cholesterol: 180
                ),
                UserInfoModel(
                    id: UUID(),
                    name: "李四年京",
                    code: "456789",
                    DoB: Calendar.current.date(from: DateComponents(year: 1963, month: 10, day: 5)) ?? Date(),
                    age: 60,
                    gender: "男",
                    image: "profilePicMan",
                    location: Location(province: "广东", city: "广州"),
                    memberID: "P320321197008063037",
                    emergencyContacts: ["赵六 1301231235"],
                    medicalAccount: "987654321",
                    socialSecurityAccount: "987654321",
                    memberType: "平台会员",
                    joinDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 10)) ?? Date(),
                    bloodPressure: 120,
                    cholesterol: 180
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
