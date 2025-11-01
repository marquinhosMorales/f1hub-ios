//
//  WikipediaImage.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

struct WikipediaImage: Decodable, Equatable {
    let source: String
    let width: Int
    let height: Int

    static func == (lhs: WikipediaImage, rhs: WikipediaImage) -> Bool {
        lhs.source == rhs.source &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height
    }
}
