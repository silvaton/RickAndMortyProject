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
                        .foregroundStyle(AppStyle.buttonTextColor)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(AppStyle.buttonBackgroundColor)
                        .clipShape(.buttonBorder)
                        .shadow(radius: Constants.shadowRadius)
                }
            }
            .padding()
        }
    }
    
    // MARK: - Constants
    private enum Constants {
        static let shadowRadius = 5.0
    }
}


#Preview {
    HomeView()
}
