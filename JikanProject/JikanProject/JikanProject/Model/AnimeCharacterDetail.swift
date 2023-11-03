//
//  AnimeCharacterDetail.swift
//  JikanProject
//
//  Created by user241654 on 11/2/23.
//

import Foundation

// La structure racine pour la réponse qui contient les données du personnage.
struct CharacterDetailResponse: Codable {
    let data: CharacterDetails
}

// Les détails du personnage, y compris les images et d'autres attributs.
// On doit mettre des "?" a certains attribut car ils peuvent etre null et donc Json.Decode n'arrive pas a decode
struct CharacterDetails: Codable {
    let mal_id: Int
    let images: CharacterImages
    let name: String
    let name_kanji: String?
    let nicknames: [String]
    let about: String?
}

// Les formats d'image disponibles pour le personnage.
struct CharacterImages: Codable {
    let jpg: CharacterImageURLs
    let webp: CharacterImageURLs
}

// Les URL d'image pour les différents formats.
struct CharacterImageURLs: Codable {
    let image_url: String?

}

