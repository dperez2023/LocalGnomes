//
//  MainView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        List(viewModel.gnomes, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.displayName)
                    .font(.headline)
            }
        }
        .task {
            await viewModel.loadData()
        }
        .alert(viewModel.loadDataErrorMessage, isPresented: $viewModel.showLoadDataError) {
            Button("Ok") { }
        } message: {
            Text("Please retry later")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
