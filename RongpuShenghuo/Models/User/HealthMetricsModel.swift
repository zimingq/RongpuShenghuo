//
//  HealthMetricsModel.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/9/24.
//

import Foundation

import Foundation

// Define ECG Data Point Structure
struct ECGDataPoint: Identifiable, Codable {
    var id = UUID()
    var timestamp: Double  // Time in seconds
    var voltage: Double    // Voltage value of the ECG at a given timestamp
}

// Updated Health Metrics Model with ECG data
struct HealthMetricsModel: Identifiable, Codable {
    var id: UUID
    var userId: UUID  // Reference to the UserInfoModel
    var heartRate: Int?
    var bloodPressure: Int?
    var bloodSugar: Int?
    var cholesterol: Int?
    var bloodOxygen: Int?
    
    // New property for ECG data
    var ecgData: [ECGDataPoint]  // Array of ECG data points
    
    // Static function to compare two health metrics
    static func == (lhs: HealthMetricsModel, rhs: HealthMetricsModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Function to generate synthetic ECG data
    static func generateSampleECGData() -> [ECGDataPoint] {
        let fs = 500.0 // Sampling rate (samples per second)
        let duration = 10.0 // Duration of ECG signal in seconds
        let t = stride(from: 0.0, to: duration, by: 1.0 / fs)
        var data: [ECGDataPoint] = []
        
        // Generate synthetic ECG signal (simplified)
        for time in t {
            let ecgSignal = sin(2 * .pi * 1.0 * time) + 0.2 * sin(2 * .pi * 2.5 * time) + 0.1 * sin(2 * .pi * 0.5 * time)
            let noise = 0.05 * Double.random(in: -1...1)
            data.append(ECGDataPoint(timestamp: time, voltage: ecgSignal + noise))
        }
        return data
    }
}

