//
//  CharactersListViewModel.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 9/5/24.
//

import Foundation
import rick_morty_swift_api

@MainActor
final class CharactersListViewModel: ObservableObject {
    @Published var charactersList: [RMCharacterModel] = []
    @Published var errorOnLoadingListString = ""
    @Published var isLoadingList = false
    
    var dataManager = CharacterDataManager()
    private var tasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        tasks.forEach({$0.cancel()})
        tasks = []
    }
    
    func loadCharactersList() {
        isLoadingList = true
        let task = Task {
            do {
                let list = try await dataManager.getAllCharacters()
                charactersList.append(contentsOf: list)
                isLoadingList = false
            } catch {
                errorOnLoadingListString = errorOnLoadingListString.description
                isLoadingList = false
            }
        }
        tasks.append(task)
    }
}
