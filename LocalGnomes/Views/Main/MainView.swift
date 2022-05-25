//
//  MainView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()

    var searchResults: [Gnome] {
        if viewModel.searchText.isEmpty {
            return viewModel.gnomes
        } else {
            return viewModel.gnomes.filter { $0.displayName.contains(viewModel.searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(searchResults) { gnome in
                        NavigationLink {
                            DetailsView(viewModel:
                                            DetailsView.ViewModel(gnome: gnome,
                                                                  gnomes: viewModel.gnomes))
                        } label: {
                            VStack {
                                Text(gnome.longDisplayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
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
                    .searchable(text: $viewModel.searchText)
                    .padding([.horizontal, .bottom])
                    .task {
                        await viewModel.loadGnomes()
                    }
                }
            }
            .navigationTitle("\(viewModel.selectedTown.rawValue) Gnomes")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
