//
//  HealthMetricsModel.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/9/24.
//

import Foundation

struct HealthMetricsModel: Identifiable, Codable {
    var id: UUID
    var userId: UUID // Reference to the UserInfoModel
    var heartRate: Int?
    var bloodPressure: Int?
    var bloodSugar: Int?
    var cholesterol: Int?

    static func == (lhs: HealthMetricsModel, rhs: HealthMetricsModel) -> Bool {
        return lhs.id == rhs.id
    }
}
