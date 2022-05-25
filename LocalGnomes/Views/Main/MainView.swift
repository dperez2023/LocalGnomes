//
//  MainView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

//MARK: - Views

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
                    .searchable(text: $viewModel.searchText, prompt: "search.bar.placeholder".localized)
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
        }.accentColor(.white)
    }
}

struct MainViewHeader: View {
    var body: some View {
        Text("main.header.title".localized)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        Spacer()
        Text("main.header.subtitle".localized)
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
                .multilineTextAlignment(.leading)
            Text(gnome.longDisplayName)
                .font(.subheadline)
                .foregroundColor(.darkBackground)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(.lightBackground)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.lightBackground)
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
