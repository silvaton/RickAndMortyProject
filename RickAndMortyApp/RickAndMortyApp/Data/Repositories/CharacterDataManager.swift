//
//  CharacterDataManager.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 9/5/24.
//

import Foundation
import rick_morty_swift_api


enum DataManagerError: Error {
    case dataFetchingError(Error)
}

public class CharacterDataManager {
    
    private let rmClient = RMClient()
    public init() {}
    
    func getAllCharacters() async throws -> [RMCharacterModel] {
        return try await withCheckedThrowingContinuation { continuation in
            rmClient.character().getAllCharacters { result in
                switch result {
                case .success(let characters):
                    let rmCharacters = characters.map { self.mapToRMCharacterModel(from: $0) }
                    continuation.resume(returning: rmCharacters)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getCharacterDetails(characterID: Int) async throws -> RMCharacterModel {
        return try await withCheckedThrowingContinuation { continuation in
            rmClient.character().getCharacterByID(id: characterID) { result in
                switch result {
                case .success(let character):
                    let rmCharacter = self.mapToRMCharacterModel(from: character)
                    continuation.resume(returning: rmCharacter)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func mapToRMCharacterModel(from character: CharacterModel) -> RMCharacterModel {
        return RMCharacterModel(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            origin: RMCharacterOriginModel(name: character.origin.name, url: character.origin.url),
            location: RMCharacterLocationModel(name: character.location.name, url: character.location.url),
            image: character.image,
            episode: character.episode,
            url: character.url,
            created: character.created
        )
    }
}
