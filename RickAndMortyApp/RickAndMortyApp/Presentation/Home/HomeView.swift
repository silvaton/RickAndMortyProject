//
//  HomeView.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 9/5/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("ramLogo")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink {
                    CharactersListView()
                } label: {
                    Text("home_begin_button_title".localized)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(.gray)
                        .clipShape(.buttonBorder)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
