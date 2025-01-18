//
//  UserInfoModel.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/7/24.
//

import Foundation
import SwiftUI

struct UserInfoModel: Identifiable, Codable {
    var id: UUID
    var name: String
    var code: String
    var DoB: Date
    var age: Int
    var gender: String
    var image: String
    
    var location: Location
    var memberID: String
    var emergencyContacts: [String]
    var medicalAccount: String
    var socialSecurityAccount: String
    var memberType: String
    var joinDate: Date
    
    var heartRate: Int?
    var bloodPressure: Int?
    var bloodSugar: Int?
    var cholesterol: Int?
    
    static func == (lhs: UserInfoModel, rhs: UserInfoModel) -> Bool {
        return lhs.id == rhs.id
    }
}
