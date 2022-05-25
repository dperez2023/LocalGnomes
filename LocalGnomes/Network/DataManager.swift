//
//  DataManager.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

enum Town: String {
    case Brastlewark

    var url: String {
        switch self {
        case .Brastlewark:
            return "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
        }
    }
}

enum ErrorType: Error {
    case invalidData
    case invalidURL
}

class DataManager {
    static func loadData(_ town: Town) async throws -> Result<[Gnome], ErrorType> {
        guard let url = URL(string: town.url) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([String: [Gnome]].self, from: data) {
                if let gnomes = decodedResponse[town.rawValue], !gnomes.isEmpty {
                    return .success(gnomes)
                } else {
                    return .failure(.invalidData)
                }
            } else {
                return .failure(.invalidData)
            }
        } catch {
            return .failure(.invalidURL)
        }
    }
}
