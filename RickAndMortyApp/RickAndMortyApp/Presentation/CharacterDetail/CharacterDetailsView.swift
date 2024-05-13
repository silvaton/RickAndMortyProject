//
//  CharacterDetailsView.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 13/5/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct CharacterDetailsView: View {
    let character: RMCharacterModel
    @Binding var isModalPresented: Bool
    
    // Constants for localized string keys
    private let statusTitleKey = "character_details_view_status_title"
    private let speccyTitleKey = "character_details_view_speccy_title"
    private let genderTitleKey = "character_details_view_gender_title"
    private let originTitleKey = "character_details_view_origin_title"
    private let numberOfEpisodesTitleKey = "character_details_view_number_of_episodes_title"
    private let buttonTittleKey = "character_details_view_dismiss_button_title"

    
    var body: some View {
        VStack {
            Text("\(character.name ?? "Unknown")")
                .font(.title).bold()
                .padding(.vertical)
            if let imageURL = character.image, let url = URL(string: imageURL) {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.capsule)
                    .padding()
            } else  {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.capsule)
                    .padding()
            }
            VStack(alignment: .leading, spacing: 10) {
                // Status
                Text("\(statusTitleKey.localized): \(character.status ?? "unknown")")
                Text("\(speccyTitleKey.localized): \(character.species ?? "unknown")")
                Text("\(genderTitleKey.localized): \(character.gender ?? "unknown")")
                Text("\(originTitleKey.localized): \(character.origin?.name ?? "unknown")")
                Text("\(numberOfEpisodesTitleKey.localized): \(character.episode?.count ?? 0)")
                        }
                        .padding()
                        
                        Spacer()
            
            Button(buttonTittleKey.localized) {
                isModalPresented = false
            }
            .padding()
            
        }
        
    }
}

#Preview {
    CharacterDetailsView(character: RMCharacterModel.mock(), isModalPresented: .constant(true))
}
