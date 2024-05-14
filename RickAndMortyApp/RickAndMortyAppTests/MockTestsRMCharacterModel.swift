//
//  MockTestsRMCharacterModel.swift
//  RickAndMortyAppTests
//
//  Created by Ton Silva on 14/5/24.
//

import Foundation
@testable import RickAndMortyApp

extension RMCharacterModel {
    static func mockTestsFemaleGender() -> RMCharacterModel {
        return RMCharacterModel(
            id: 2,
            name: "Morty",
            status: "Alive",
            species: "Human",
            type: nil,
            gender: "Female",
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil
        )
    }
    
    static func mockTestsMaleGender() -> RMCharacterModel {
        return RMCharacterModel(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil
        )
    }
    
    static func mockTestsUnkownCharacter() -> RMCharacterModel {
        return RMCharacterModel(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: RMCharacterOriginModel(name: "Unknown", url: nil),
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil
        )
    }
    
    static func mockTestsMultipleEpisodes() -> RMCharacterModel {
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
