//
//  RecipeList.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct RecipeList: View {
	@Environment(ModelData.self) var model
	
	var body: some View {
		@Bindable var model = model
		List {
			if model.searchText.isEmpty {
				CusinePicker()
			}
			
			ForEach(model.displayRecipes) { recipe in
				if let link = recipe.url, let url = URL(string: link) {
					NavigationLink {
						WebView(url: url)
							.navigationTitle(recipe.name)
							.navigationBarTitleDisplayMode(.inline)
							.toolbar {
								if let link = recipe.videoUrl, let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
									ToolbarItem(placement: .topBarTrailing) {
										Button {
											UIApplication.shared.open(url, options: [:], completionHandler: { success in
												print(success ? "Success" : "Failed")
											})
										} label: {
											Image(systemName: "video")
										}
									}
								}
							}
					} label: {
						RecipeRow(recipe: recipe)
					}
				} else {
					RecipeRow(recipe: recipe)
				}
			}
		}
		.navigationTitle("Recipes")
		.searchable(text: $model.searchText) {
			
		}
		.listStyle(.plain)
	}
}

#Preview {
	let model = ModelData()
	model.recipes = RecipeService.preview()
	return NavigationStack {
		RecipeList()
	}
	.environment(model)
}
