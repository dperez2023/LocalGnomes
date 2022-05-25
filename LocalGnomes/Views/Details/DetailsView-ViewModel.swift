//
//  DetailsView-ViewModel.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

extension DetailsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var gnome: Gnome
        @Published var friends: [Gnome]?

        var presentableFriends: [Gnome] {
            if let friends = self.friends {
                return friends
            } else {
                return []
            }
        }

        init(gnome: Gnome, gnomes: [Gnome]) {
            self.gnome = gnome
            self.friends = gnome.friends.map { gnomeFriend in
                if let friend = gnomes.first(where: { $0.name == gnomeFriend }) {
                    return friend
                } else {
                    fatalError("DetailsView-ViewModel: Gnome's name doesn't match gnome list")
                }
            }
        }
    }
}
