//
//  Recipe.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
	var id: String // "eed6005f-f8c8-451f-98d0-4088e2b40eb6"
	var cuisine: String // "British"
	var name: String // "Bakewell Tart"
	var image: String // "https://some.url/large.jpg"
	var thumbnail: String // "https://some.url/small.jpg"
	var url: String? // "https://some.url/index.html"
	var videoUrl: String? // "https://www.youtube.com/watch?v=some.id"

	enum CodingKeys: String, CodingKey {
		case cuisine
		case name
		case image = "photo_url_large"
		case thumbnail = "photo_url_small"
		case id = "uuid"
		case url = "source_url"
		case videoUrl = "youtube_url"
	}
}

extension Recipe {
	var flag: String {
		switch cuisine {
		case "Malaysian":
			return "🇲🇾" // Malaysia
		case "British":
			return "🇬🇧" // United Kingdom
		case "American":
			return "🇺🇸" // United States
		case "Canadian":
			return "🇨🇦" // Canada
		case "Italian":
			return "🇮🇹" // Italy
		case "Tunisian":
			return "🇹🇳" // Tunisia
		case "French":
			return "🇫🇷" // France
		case "Polish":
			return "🇵🇱" // Poland
		case "Portuguese":
			return "🇵🇹" // Portugal
		case "Greek":
			return "🇬🇷" // Greece
		case "Russian":
			return "🇷🇺" // Russia
		case "Croatian":
			return "🇭🇷" // Croatia
		default:
			return "🏳️" // Unknown
		}
	}
}
