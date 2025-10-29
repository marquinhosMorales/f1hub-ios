//
//  Untitled.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

struct WikipediaSummary: Decodable, Equatable {
    let title: String
    let description: String?
    let extract: String?
    let thumbnail: WikipediaImage?
    let originalimage: WikipediaImage?

    static func == (lhs: WikipediaSummary, rhs: WikipediaSummary) -> Bool {
        lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.extract == rhs.extract &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.originalimage == rhs.originalimage
    }
}
