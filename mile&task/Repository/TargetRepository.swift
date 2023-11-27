//
//  TargetRepository.swift
//  mile&task
//
//  Created by 中川 匠 on 2023/11/27.
//

import Foundation

actor TargetRepository{
    typealias API = Router
    
    static func getTargets() async throws -> [Target] {
        let value  = try await API.request(.getTargets)
            .serializingDecodable(TargetList.self)
            .value
        return value.data
    }
}
