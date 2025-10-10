//
//  Untitled.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

struct WikipediaSummary: Decodable {
    let title: String
    let description: String?
    let extract: String?
    let thumbnail: WikipediaImage?
    let originalimage: WikipediaImage?
}
