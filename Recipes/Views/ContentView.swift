//
//  ContentView.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct ContentView: View {
	@State var model = ModelData()
	@State var showDataSourceDialog = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				switch model.dataResponse {
				case .valid:
					RecipeList()
				case .malformed:
					VStack {
						Image(systemName: "exclamationmark.triangle")
							.imageScale(.large)
						Text("Malformed Data")
							.font(.headline)
					}
				case .empty:
					VStack {
						Image(systemName: "fork.knife")
							.imageScale(.large)
						Text("No Recipes")
							.font(.headline)
					}
				case .none:
					ProgressView()
				}
			}
			.navigationTitle("Recipes")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						showDataSourceDialog = true
					} label: {
						Image(systemName: "ant")
					}
				}
			}
		}
		.environment(model)
		.refreshable {
			try? await model.fetchRecipes()
		}
		.task {
			Task {
				try await model.fetchRecipes()
			}
		}
		.confirmationDialog("Debug", isPresented: $showDataSourceDialog) {
			ForEach(RecipeService.Source.allCases) { source in
				Button("\(source.rawValue.capitalized) Data") {
					model.dataSource = source
					Task {
						try? await model.fetchRecipes()
					}
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		ContentView()
	}
}
