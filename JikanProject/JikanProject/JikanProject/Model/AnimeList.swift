//
//  Data.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import Foundation

struct AnimeResponse: Codable {
    let data: [Anime]
}

struct Anime: Codable {
    let mal_id: Int
    let url: String
    let images: AnimeImages
    let title: String
    let score: Float

    var malID: Int {
        return mal_id
    }

    var image_url: String {
        return images.jpg.image_url
    }
}

struct AnimeImages: Codable {
    let jpg: AnimeImageURLs
}

struct AnimeImageURLs: Codable {
    let image_url: String
}

