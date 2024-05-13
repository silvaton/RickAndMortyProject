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
        isLoadingList = false
        tasks.append(task)
    }
    
    func buildCharacterResume(character: RMCharacterModel) -> String {
        let genderPronoun = determineGenderPronoun(character: character)
        let planetDescription = formatPlanetDescription(character: character)
        let episodeDescription = formatEpisodeDescription(character: character)
        
        return "\(character.name ?? "") \(planetDescription). Since the beginning of the program \(genderPronoun) has participated in \(episodeDescription)."
    }

    func determineGenderPronoun(character: RMCharacterModel) -> String {
        switch character.gender?.lowercased() {
            case "male":
                return "he"
            case "female":
                return "she"
            default:
                return "they"
        }
    }

    func formatPlanetDescription(character: RMCharacterModel) -> String {
        guard let originName = character.origin?.name?.lowercased(), !originName.isEmpty else {
            return "has your origin still unknown"
        }
        if originName == "unknown" {
            return "has your origin still unknown"
        }
        return "is from the planet called \(originName.capitalized)"
    }

    func formatEpisodeDescription(character: RMCharacterModel) -> String {
        let episodeCount = character.episode?.count ?? 0
        let episodeDescription = episodeCount < 2 ? "\(episodeCount) episode" : "\(episodeCount) episodes"
        return episodeDescription
    }
}
