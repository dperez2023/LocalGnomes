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
        @Published var loadDataErrorMessage = ""
        @Published var selectedTown: Town = .Brastlewark
        @Published var searchText = ""

        func loadGnomes() async {
            await DataManager.loadData(selectedTown, completion: { response, error in
                DispatchQueue.main.async {
                    if let response = response {
                        self.gnomes = response
                    } else if let error = error {
                        self.loadDataErrorMessage = "Failed to load: \(error.rawValue)"
                        self.showLoadDataError = true
                    } else {
                        fatalError("")
                    }
                }
            })
        }
    }
}