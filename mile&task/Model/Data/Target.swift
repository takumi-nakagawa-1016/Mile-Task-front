//
//  Target.swift
//  mile&task
//
//  Created by 中川 匠 on 2023/11/25.
//

import Foundation

struct Target: Codable{
    let id: Int
    let name: String
    let dueTime: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dueTime = "due_time"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct TargetList: Codable{
    let data: [Target]
}
