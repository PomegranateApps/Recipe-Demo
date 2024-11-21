//
//  CusinePicker.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct CusinePicker: View {
	@Environment(ModelData.self) var model
	
    var body: some View {
		ScrollView(.horizontal) {
			LazyHStack(spacing: 15) {
				ForEach(model.cusineTags, id: \.self) { tag in
					Button(tag) {
						model.toggle(tag: tag)
					}
					.buttonStyle(FilterButtonStyle(selected: model.selectedTags.contains(tag)))
				}
			}
			.padding(.horizontal, 20)
			.padding(.vertical, 10)
		}
		.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
	let model = ModelData()
	model.recipes = RecipeService.preview()
    return CusinePicker()
		.environment(model)
}
