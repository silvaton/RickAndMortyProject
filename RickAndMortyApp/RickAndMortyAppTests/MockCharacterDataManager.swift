//
//  MockCharacterDataManager.swift
//  RickAndMortyAppTests
//
//  Created by Ton Silva on 14/5/24.
//

import Foundation
@testable import RickAndMortyApp

class MockCharacterDataManager: CharacterDataManager {
    var characters: [RMCharacterModel]
    var error: Error?
    
    init(characters: [RMCharacterModel] = [], error: Error? = nil) {
        self.characters = characters
        self.error = error
    }
    
    override func getAllCharacters() async throws -> [RMCharacterModel] {
        if let error = error {
            throw error
        } else {
            return characters
        }
    }
}
