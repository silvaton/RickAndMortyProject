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

final class CharacterDataManager {
    
    private let rmClient = RMClient()
    private init() {}
    
    func getAllCharacters() async throws -> [CharacterModel] {
        return try await withCheckedThrowingContinuation { continuation in
            rmClient.character().getAllCharacters { result in
                switch result {
                case .success(let characters):
                    continuation.resume(returning: characters)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getCharacterDetails(characterID: Int) async throws -> CharacterModel {
        return try await withCheckedThrowingContinuation { continuation in
            rmClient.character().getCharacterByID(id: characterID) { result in
                switch result {
                case .success(let character):
                    continuation.resume(returning: character)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
