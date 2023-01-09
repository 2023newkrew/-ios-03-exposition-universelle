//
//  ExpositionItem.swift
//  Expo1900
//
//  Created by kakao on 2023/01/09.
//

import Foundation

struct ExpositionItem: Decodable {
    let name: String
    let imageName: String
    let shortDescription: String
    let description: String
    
    enum codingKeys: String, CodingKey {
        case name
        case imageName = "image_name"
        case shortDescription = "short_desc"
        case description = "desc"
    }
}
