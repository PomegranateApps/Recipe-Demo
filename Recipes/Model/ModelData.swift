//
//  ModelData.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI
import Observation

@Observable final class ModelData {
	var dataSource: RecipeService.Source = .valid
	var dataResponse: RecipeService.Source?
	var recipes: [Recipe] = []
	var searchText: String = ""
	var selectedTags: [String] = []
	var imageStore: [URL : Image] = [:]
	
	var displayRecipes: [Recipe] {
		if searchText == "" {
			if !selectedTags.isEmpty {
				return recipes.filter {
					selectedTags.contains($0.cuisine)
				}
			}
			
			return recipes
		}
		
		return recipes.filter {
			let text = $0.name + " " + $0.cuisine
			return text.localizedCaseInsensitiveContains(searchText)
		}
	}
	
	func toggle(tag: String) {
		if selectedTags.contains(tag) {
			selectedTags.removeAll {
				$0 == tag
			}
		} else {
			selectedTags += [tag]
		}
	}
	
	func fetchRecipes() async throws {
		dataResponse = nil
		do {
			recipes = try await RecipeService.fetch(from: dataSource)
			selectedTags = []
			dataResponse = recipes.count == 0 ? .empty : .valid
		} catch {
			dataResponse = .malformed
		}
	}
	
	var cusineTags: [String] {
		Array(Set(recipes.map { $0.cuisine })).sorted(using: .localized)
	}
	
	func fetchImage(url: URL) async throws -> Image? {
		if let cachedImage = imageStore[url] {
			return cachedImage
		}
		
		// Download the image
		let (data, _) = try await URLSession.shared.data(from: url)
		if let uiImage = UIImage(data: data) {
			let image = Image(uiImage: uiImage)
			imageStore[url] = image
			return image
		}
		
		return nil
	}
}
