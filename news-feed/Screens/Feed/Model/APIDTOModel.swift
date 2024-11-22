//
//  FeedAPIDto.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/21/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import Foundation

typealias APIDTOModel = [SingleModel]

struct SingleModel: Codable,Hashable {
    let id: Int?
    let title, description, details: String?
    let image: String?
    let category: Category?
}

enum Category: String, Codable,Hashable {
    case desktop = "desktop"
    case mobile = "mobile"
}


