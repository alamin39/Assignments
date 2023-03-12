//
//  DataModel.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/14.
//

import Foundation


struct RepositoryInfo: Codable {
    let items: [ItemInfo]?
}

struct ItemInfo: Codable {
    let fullName: String?
    let htmlURL: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case htmlURL = "html_url"
    }
}
