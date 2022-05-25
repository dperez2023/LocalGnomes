//
//  DetailsView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

//MARK: - Views

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
                VStack {
                    Text(String(format: "details.age.title".localized, viewModel.gnome.age))
                        .detailsTitleStyle()
                    Text(String(format: "details.weight.title".localized, viewModel.gnome.weight))
                        .detailsTitleStyle()
                    Text(String(format: "details.height.title".localized, viewModel.gnome.height))
                        .detailsTitleStyle()
                    Text(String(format: "details.hairColor.title".localized, viewModel.gnome.hairColor))
                        .detailsTitleStyle()
                    Text(String(format: "details.professions.title".localized, viewModel.gnome.professionsList))
                        .detailsTitleStyle()
                }
                .multilineTextAlignment(.leading)
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

//MARK: - Modifiers

struct DetailsLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding([.horizontal])
            .multilineTextAlignment(.leading)
    }
}
