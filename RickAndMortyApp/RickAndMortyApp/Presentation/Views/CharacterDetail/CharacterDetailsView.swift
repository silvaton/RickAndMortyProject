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
    
    // Another approach to use the localizables:
    private let statusTitleKey = "character_details_view_status_title"
    private let speccyTitleKey = "character_details_view_speccy_title"
    private let genderTitleKey = "character_details_view_gender_title"
    private let originTitleKey = "character_details_view_origin_title"
    private let numberOfEpisodesTitleKey = "character_details_view_number_of_episodes_title"
    private let buttonTittleKey = "character_details_view_dismiss_button_title"
    private let unknownTitleKey = "unknown_localizable_title"
    private let buttontTitleKey = "character_details_view_dismiss_button_title"
    
    var body: some View {
        VStack {
            Text("\(character.name ?? unknownTitleKey)")
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
            
            VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                Text("\(statusTitleKey.localized): \(character.status ?? unknownTitleKey)")
                Text("\(speccyTitleKey.localized): \(character.species ?? unknownTitleKey)")
                Text("\(genderTitleKey.localized): \(character.gender ?? unknownTitleKey)")
                Text("\(originTitleKey.localized): \(character.origin?.name?.capitalized ?? unknownTitleKey)")
                Text("\(numberOfEpisodesTitleKey.localized): \(character.episode?.count ?? 0)")
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                isModalPresented = false
            }, label: {
                Text(buttontTitleKey.localized)
                    .font(.title)
                    .foregroundStyle(AppStyle.buttonTextColor)
                    .padding(Constants.regularPadding)
                    .padding(.horizontal)
                    .background(AppStyle.buttonBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.buttonCornerRadius))
            })
            .padding()
        }
    }
    // MARK: - Constants
    private enum Constants {
        static let regularPadding = 10.0
        static let buttonCornerRadius = 8.0
        static let vstackSpacing = 10.0
    }
}

#Preview {
    CharacterDetailsView(character: RMCharacterModel.mock(), isModalPresented: .constant(true))
}
