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
        List {
            GnomeInformationView(gnome: viewModel.gnome)
            if !viewModel.presentableFriends.isEmpty {
                Section("details.friends.title".localized) {
                    ForEach(viewModel.presentableFriends) { friend in
                        Button(friend.displayName) {
                            viewModel.presentFriend = true
                            viewModel.presentedFriend = friend
                        }.buttonStyle(.bordered)
                            .foregroundColor(.lightBackground)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
            }

            Section("details.picture.title".localized) {
                AsyncImage(url: URL(string: viewModel.gnome.thumbnail), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
                .aspectRatio(contentMode: .fit)
            }
            .navigationTitle(viewModel.gnome.displayName)
            .clipped()
            .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle(viewModel.gnome.displayName)
        .foregroundColor(.white)
        .sheet(isPresented: $viewModel.presentFriend) {
            NavigationView {
                DetailsView(viewModel: DetailsView.ViewModel(gnome: viewModel.presentedFriend!, gnomes: viewModel.gnomes))
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsView.ViewModel(gnome: Gnome(), gnomes: []))
    }
}

struct GnomeInformationView: View {
    var gnome: Gnome

    var body: some View {
        Section("details.personal.title".localized) {
            Text(String(format: "details.age.title".localized, gnome.age))
                .detailsTitleStyle()
            Text(String(format: "details.weight.title".localized, gnome.weight))
                .detailsTitleStyle()
            Text(String(format: "details.height.title".localized, gnome.height))
                .detailsTitleStyle()
            Text(String(format: "details.hairColor.title".localized, gnome.hairColor))
                .detailsTitleStyle()
            Text(String(format: "details.professions.title".localized, gnome.professionsList))
                .detailsTitleStyle()
        }
    }
}

//MARK: - Modifiers

struct DetailsLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.white)
            .padding([.horizontal])
            .multilineTextAlignment(.leading)
            .clipped()
    }
}
