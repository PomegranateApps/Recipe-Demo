//
//  RecipeService.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct RecipeService {
	static func fetch(from source: Source = .valid) async throws -> [Recipe] {
		guard let url = source.url else {
			return []
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			return try JSONDecoder().decode(Response.self, from: data).recipes
		} catch {
			print(error)
			throw error
		}
	}
	
	static func preview() -> [Recipe] {
		let asset = NSDataAsset(name: "recipes")
		guard let fileData = asset?.data else {
			return []
		}
		
		guard let response = try? JSONDecoder().decode(Response.self, from: fileData) else {
			return []
		}
		
		return response.recipes
	}
	
	struct Response: Codable {
		var recipes: [Recipe]
	}
	
	enum Source: String, CaseIterable, Identifiable {
		case valid
		case malformed
		case empty
		
		var id: String {
			rawValue
		}
		
		var url: URL? {
			switch self {
			case .valid:
				URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
			case .malformed:
				URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
			case .empty:
				URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
			}
		}
	}
}
