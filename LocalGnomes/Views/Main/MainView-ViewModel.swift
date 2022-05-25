//
//  MainView-ViewModel.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        @Published var gnomes = [Gnome]()
        @Published var showLoadDataError = false
        @Published var searchText = ""

        var loadDataErrorMessage = ""
        var selectedTown: Town = .Brastlewark
        var searchResults: [Gnome] {
            if searchText.isEmpty {
                return gnomes
            } else {
                return gnomes.filter {
                    $0.displayName.contains(searchText) || $0.professions.contains(where: {$0 == searchText})}
            }
        }

        func loadGnomes() async {
            do {
                let result = try await DataManager.loadData(selectedTown)
                switch result {
                case .success(let gnomes):
                    self.gnomes = gnomes
                case .failure(let error):
                    self.loadDataErrorMessage = "Failed to load: \(error.localizedDescription)"
                    self.showLoadDataError = true
                }
            } catch {
                fatalError("Load data with no response and no error")
            }
        }
    }
}
