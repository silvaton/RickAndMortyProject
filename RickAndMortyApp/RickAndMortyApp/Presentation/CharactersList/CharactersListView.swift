//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 9/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()
    @State private var showModal = false
    @State private var selected: RMCharacterModel?
    @State private var searchText = ""
    
    var filteredCharacters: [RMCharacterModel] {
        if searchText.isEmpty {
            return viewModel.charactersList
        } else {
            return viewModel.charactersList.filter {$0.name?.contains(searchText) ?? false }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                if !viewModel.isLoadingList {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(filteredCharacters) { character in
                            characterRowView(character: character)
                        }
                    }
                } else if viewModel.errorOnLoadingListString.isEmpty {
                    ProgressView()
                } else {
                    Text(viewModel.errorOnLoadingListString)
                }
            }
            .searchable(text: $searchText, prompt: Text("Search a name..."))
        }
        .padding()
        .onAppear {
            viewModel.loadCharactersList()
        }
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
    
    func characterRowView(character: RMCharacterModel) -> some View {
        HStack {
            getProfileImage(characterStringUrl: character.image)
            VStack(alignment: .leading) {
                Text(character.name ?? "")
                    .font(.headline)
                Text("Planet: \(character.origin?.name ?? "")")
                    .font(.subheadline)
                Text("Speccy: \(character.species ?? "")")
                    .font(.subheadline)
            }
        }
    }
    
    func getProfileImage(characterStringUrl: String?) -> some View {
        if let stringURL = characterStringUrl, let imageURL = URL(string: stringURL) {
            return AnyView(
                WebImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } placeholder: {
                    ZStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        ProgressView()
                    }
                }
            )
        } else {
            return AnyView(
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            )
        }
    }
}

#Preview {
    CharactersListView()
}
