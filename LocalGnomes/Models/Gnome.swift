//
//  Gnome.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

enum Gender: String {
    case male
    case female
    case unknown
}

struct Gnome: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name, thumbnail, age, weight, height, hair_color, professions, friends
    }

    let id: Int
    let name: String
    let thumbnail: String
    let age: Int
    let weight: Float
    let height: Float
    let hairColor: String
    let professions: [String]
    let friends: [String]

    var displayName: String {
        name
    }

    var longDisplayName: String {
        "\(name) (\(gender.rawValue))"
    }

    private var gender: Gender {
        hairColor == "Pink" ? .female : .male
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(age, forKey: .age)
        try container.encode(weight, forKey: .weight)
        try container.encode(height, forKey: .height)
        try container.encode(hairColor, forKey: .hair_color)
        try container.encode(professions, forKey: .professions)
        try container.encode(friends, forKey: .friends)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        age = try container.decode(Int.self, forKey: .age)
        weight = try container.decode(Float.self, forKey: .weight)
        height = try container.decode(Float.self, forKey: .height)
        hairColor = try container.decode(String.self, forKey: .hair_color)
        professions = try container.decode([String].self, forKey: .professions)
        friends = try container.decode([String].self, forKey: .friends)
    }

    init() {
        id = 0
        name = ""
        thumbnail = ""
        age = 0
        weight = 0
        height = 0
        hairColor = ""
        professions = []
        friends = []
    }
}
