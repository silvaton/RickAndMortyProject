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
                            
                            Text("Status: \(character.status ?? "Unknown")")
                            Text("Species: \(character.species ?? "Unknown")")
                            Text("Gender: \(character.gender ?? "Unknown")")
                            Text("Origin: \(character.origin?.name ?? "Unknown")")
                        }
                        .padding()
                        
                        Spacer()
            
            Button("Dismiss") {
                isModalPresented = false
            }
            .padding()
            
        }
        
    }
}

#Preview {
    CharacterDetailsView(character: RMCharacterModel.mock(), isModalPresented: .constant(true))
}
