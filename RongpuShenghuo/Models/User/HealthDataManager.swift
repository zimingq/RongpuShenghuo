//
//  HealthDataManager.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/9/24.
//

import Foundation
import Combine

import SwiftUI

class HealthDataManager: ObservableObject {
    @Published var healthMetrics: [UUID: HealthMetrics] = [:] // Keyed by user ID
    
    struct HealthMetrics: Codable {
        var heartRate: Int?
        var bloodPressure: Int?
        var bloodSugar: Int?
        var cholesterol: Int?
        var bloodOxygen: Int?
    }
    
    func updateHealthMetrics(for userId: UUID, metrics: HealthMetrics) {
        healthMetrics[userId] = metrics
        // Save updated metrics
        saveHealthMetrics()
    }
    
    func getHealthMetrics(for userId: UUID) -> HealthMetrics? {
        return healthMetrics[userId]
    }
    
    func saveHealthMetrics() {
        if let encodedData = try? JSONEncoder().encode(healthMetrics) {
            UserDefaults.standard.set(encodedData, forKey: "savedHealthMetrics")
        }
    }
    
    init() {
        // Load saved health metrics or initialize with default values
        if let data = UserDefaults.standard.data(forKey: "savedHealthMetrics"),
           let savedMetrics = try? JSONDecoder().decode([UUID: HealthMetrics].self, from: data) {
            healthMetrics = savedMetrics
        }
    }
}
