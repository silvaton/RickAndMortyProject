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
            if !viewModel.isLoadingList && !viewModel.charactersList.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: Constants.stackSpacing) {
                        ForEach(filteredCharacters) { character in
                            characterRowView(character: character)
                                .onTapGesture {
                                    selectedCharacter = character
                                }
                        }
                    }
                }
                .searchable(text: $searchText,
                            prompt: Text("character_list_view_search_box_placeholder".localized))
                
            } else if viewModel.errorOnLoadingListString.isEmpty && viewModel.isLoadingList {
                ProgressView()
            } else if !viewModel.errorOnLoadingListString.isEmpty {
                VStack {
                    Text("character_list_view_error_title".localized)
                    Button(action: {
                        viewModel.loadCharactersList()
                    }, label: {
                        Text("character_list_view_error_button_title".localized)
                            .font(.title)
                            .foregroundStyle(AppStyle.buttonTextColor)
                            .padding(Constants.buttonPadding)
                            .padding(.horizontal)
                            .background(AppStyle.buttonBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: Constants.buttonCornerRadius))
                    })
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .navigationTitle("character_list_view_navigation_title".localized)
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
                        .frame(width: Constants.imageWidth, 
                               height: Constants.imageHeigh)
                        .clipShape(Circle())
                } placeholder: {
                    ZStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: Constants.imageWidth,
                                   height: Constants.imageHeigh)
                        
                        ProgressView()
                    }
                }
            )
        } else {
            return AnyView(
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: Constants.imageWidth,
                           height: Constants.imageHeigh)
            )
        }
    }
    
    // MARK: - Constants
    private enum Constants {
        static let imageWidth = 70.0
        static let imageHeigh = 70.0
        static let buttonPadding = 10.0
        static let buttonCornerRadius = 10.0
        static let stackSpacing = 20.0
    }
}

#Preview {
    CharactersListView()
}
