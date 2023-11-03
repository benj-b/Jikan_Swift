//
//  AnimePerso.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import Foundation

struct CharacterResponse: Codable {
    let data: [CharacterData]
}

struct CharacterData: Codable {
    let character: Character?
    let role: String
    let favorites: Int
}

struct Character: Codable {
    let mal_id: Int
    let url: String
    let images: Images
    let name: String
}

struct Images: Codable {
    let jpg: Image
    let webp: Image
}

struct Image: Codable {
    let image_url: String
    let small_image_url: String?
}
