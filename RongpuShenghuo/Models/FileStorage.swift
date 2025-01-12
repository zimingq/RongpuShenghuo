//
//  fileStorage.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 7/30/24.
//

import Foundation

class FileStorage {
    static let shared = FileStorage()
    
    private func fileURL(for fileName: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    func save<T: Codable>(items: [T], fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: fileURL(for: fileName), options: .atomic)
        } catch {
            print("Failed to save items: \(error)")
        }
    }
    
    func load<T: Codable>(fileName: String) -> [T] {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL(for: fileName))
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            print("Failed to load items: \(error)")
            return []
        }
    }
    }
