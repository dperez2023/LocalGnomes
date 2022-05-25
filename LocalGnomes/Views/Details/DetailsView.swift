//
//  DetailsView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var viewModel = ViewModel()
    @State var gnome: Gnome
    @State var gnomes: [Gnome]

    var body: some View {
        VStack {
            Text("Friends with:")
            List {
                ForEach(viewModel.presentableFriends) { friend in
                    Text(friend.displayName)
                }
            }.navigationTitle(viewModel.gnomeName)
        }
        .onAppear {
            viewModel.initialize(gnome: gnome, gnomes: gnomes) //WIP
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(gnomePrivate: Gnome(), gnomesPrivate: [])
    }
}
