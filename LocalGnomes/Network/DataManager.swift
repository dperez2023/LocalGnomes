//
//  DataManager.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

enum Town: String {
    case Brastlewark
}

enum ErrorType: String {
    case invalidData
    case invalidURL
}

class DataManager {
    static func loadData(_ town: Town, completion: @escaping ([Gnome]?, ErrorType?) -> Void) async {
        guard let url = URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json") else {
            completion(nil, .invalidURL)
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([String: [Gnome]].self, from: data) {
                if let gnomes = decodedResponse[town.rawValue], !gnomes.isEmpty {
                    completion(gnomes, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .invalidData)
            }
        } catch {
            completion(nil, .invalidURL)
        }
    }
}
