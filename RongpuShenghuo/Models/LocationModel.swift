//
//  LocationModel.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/12/24.
//

import Foundation

struct Location: Codable, Identifiable {
    var id = UUID()
    var province: String
    var city: String
}
