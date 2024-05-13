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
    @State private var selectedCharacter: RMCharacterModel?
    @State private var searchText = ""
    @State private var isModalPresented = false

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
                                .onTapGesture {
                                    selectedCharacter = character
                                }
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
        .onChange(of: selectedCharacter, { _, _ in
            isModalPresented = true
        })
        .sheet(isPresented: $isModalPresented, content: {
            if let selectedCharacter = selectedCharacter {
                CharacterDetailsView(character: selectedCharacter, isModalPresented: $isModalPresented)
            }
        })
        
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
    
    func characterRowView(character: RMCharacterModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                getProfileImage(characterStringUrl: character.image)
                VStack(alignment: .leading) {
                    Text(character.name ?? "")
                        .font(.headline)
                    Text("\("character_list_view_speccy_title".localized): \(character.species ?? "")")
                        .font(.subheadline)
                    Text("\("character_list_view_status_title".localized): \(character.status ?? "")")
                        .font(.subheadline)
                }
            }
            .padding(.vertical)
            Text(viewModel.buildCharacterResume(character: character))
            Divider()
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
