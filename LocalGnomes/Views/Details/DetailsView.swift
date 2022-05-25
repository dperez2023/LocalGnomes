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
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: viewModel.gnome.thumbnail), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                if !viewModel.presentableFriends.isEmpty {
                    List {
                        ForEach(viewModel.presentableFriends) { friend in
                            Button(friend.displayName) {
                                viewModel.presentFriend = true
                                viewModel.presentedFriend = friend
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                    }
                    .navigationTitle(viewModel.gnome.displayName)
                }
            }
            .foregroundColor(.white)
            .background(.lightBackground)
            .preferredColorScheme(.dark)
        }
        .sheet(isPresented: $viewModel.presentFriend) {
            DetailsView(viewModel: DetailsView.ViewModel(gnome: viewModel.presentedFriend!, gnomes: viewModel.gnomes))
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsView.ViewModel(gnome: Gnome(), gnomes: []))
    }
}
