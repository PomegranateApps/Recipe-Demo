//
//  RecipeRow.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct RecipeRow: View {
	@Environment(ModelData.self) var model
	var recipe: Recipe

	var body: some View {
		HStack {
			if let url = URL(string: recipe.thumbnail) {
				ZStack {
					if let image = model.imageStore[url] {
						image.resizable().scaledToFit()
					} else {
						ProgressView()
					}
				}
				.frame(width: 60, height: 60)
				.clipShape(RoundedRectangle(cornerRadius: 8))
			}

			VStack(alignment: .leading) {
				Text(recipe.name)
					.font(.headline)
				Text("\(recipe.flag) \(recipe.cuisine) Cuisine")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			
			Spacer()
		}
		.task {
			if let url = URL(string: recipe.thumbnail) {
				let _ = try? await model.fetchImage(url: url)
			}
		}
	}
}

#Preview {
	RecipeRow(recipe: RecipeService.preview().first!)
		.padding()
}
