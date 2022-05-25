//
//  MainView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                MainViewHeader()
                LazyVStack {
                    ForEach(viewModel.searchResults) { gnome in
                        NavigationLink {
                            DetailsView(viewModel: DetailsView.ViewModel(gnome: gnome, gnomes: viewModel.gnomes))
                        } label: {
                            MainGnomeView(gnome: gnome)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Search by name or profession")
                    .padding([.horizontal, .bottom])
                    .task {
                        await viewModel.loadGnomes()
                    }
                }
            }
            .navigationTitle("\(viewModel.selectedTown.rawValue) Gnomes")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .alert(viewModel.loadDataErrorMessage, isPresented: $viewModel.showLoadDataError) { }
        }
    }
}

struct MainViewHeader: View {
    var body: some View {
        Text("Gnome's professions are the most relevant to help you on your adventure.")
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        Spacer()
        Text("Use the search bar if you know their name or need to browse for an specific profession")
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

struct MainGnomeView: View {
    var gnome: Gnome

    var body: some View {
        VStack {
            Text(gnome.professionsList)
                .font(.headline)
                .foregroundColor(.white)
                .padding([.horizontal])
            Text(gnome.longDisplayName)
                .font(.subheadline)
                .foregroundColor(.darkBackground)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(.lightBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
