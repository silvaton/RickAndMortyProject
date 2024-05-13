//
//  RMCharacterModel.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 9/5/24.
//

import Foundation

public struct RMCharacterModel: Codable, Identifiable {
    public let id: Int?
    public let name: String?
    public let status: String?
    public let species: String?
    public let type: String?
    public let gender: String?
    public let origin: RMCharacterOriginModel?
    public let location: RMCharacterLocationModel?
    public let image: String?
    public let episode: [String]?
    public let url: String?
    public let created: String?
    
    public init(id: Int?, name: String?, status: String?, species: String?, type: String?, gender: String?, origin: RMCharacterOriginModel?, location: RMCharacterLocationModel?, image: String?, episode: [String]?, url: String?, created: String?) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

public struct RMCharacterOriginModel: Codable {
    public let name: String?
    public let url: String?
    
    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

public struct RMCharacterLocationModel: Codable {
    public let name: String?
    public let url: String?
    
    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

extension RMCharacterModel: Equatable {
    public static func == (lhs: RMCharacterModel, rhs: RMCharacterModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.status == rhs.status &&
            lhs.species == rhs.species &&
            lhs.type == rhs.type &&
            lhs.gender == rhs.gender &&
            lhs.origin == rhs.origin &&
            lhs.location == rhs.location &&
            lhs.image == rhs.image &&
            lhs.episode == rhs.episode &&
            lhs.url == rhs.url &&
            lhs.created == rhs.created
    }
}

// Equatable extension for RMCharacterOriginModel
extension RMCharacterOriginModel: Equatable {
    public static func == (lhs: RMCharacterOriginModel, rhs: RMCharacterOriginModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.url == rhs.url
    }
}

// Equatable extension for RMCharacterLocationModel
extension RMCharacterLocationModel: Equatable {
    public static func == (lhs: RMCharacterLocationModel, rhs: RMCharacterLocationModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.url == rhs.url
    }
}

extension RMCharacterModel {
    static func mock() -> RMCharacterModel {
        return RMCharacterModel(
            id: 2,
            name: "Morty Smit",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: RMCharacterOriginModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
            location: RMCharacterLocationModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"],
            url: "https://rickandmortyapi.com/api/character/2",
            created: "2017-11-04T18:50:21.651Z"
        )
    }
}
