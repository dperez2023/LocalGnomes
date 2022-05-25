//
//  DetailsView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.gnome.thumbnail), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            Text("Friends with:")
                .padding(.vertical)
            List {
                ForEach(viewModel.presentableFriends) { friend in
                    Text(friend.displayName)
                }
            }.navigationTitle(viewModel.gnome.displayName)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsView.ViewModel(gnome: Gnome(), gnomes: []))
    }
}
