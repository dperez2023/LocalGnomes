//
//  ContentView.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gnomes = [Gnome]()

    var body: some View {
        List(gnomes, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.displayName)
                    .font(.headline)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        await DataManager.loadData(.Brastlewark, completion: { response, error in
            if let response = response {
                gnomes = response
            } else if let error = error {
                print("Present error alert \(error)")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
