//
//  FilterButtonStyle.swift
//  Recipes
//
//  Created by Chris DeSalvo on 11/20/24.
//

import SwiftUI

struct FilterButtonStyle: ButtonStyle {
	var selected: Bool

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(selected ? .white : .primary)
			.padding(10)
			.background {
				if selected {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(Color.accentColor)
				} else {
					RoundedRectangle(cornerRadius: 8)
						.stroke(style: .init(lineWidth: 1))
						.foregroundStyle(Color(uiColor: .systemGray4))
				}
			}
			.scaleEffect(configuration.isPressed ? 0.9 : 1.0)
			.animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
	}
}

#Preview {
	VStack {
		Button("Default") {
			
		}
		.buttonStyle(FilterButtonStyle(selected: false))
		
		Button("Selected") {
			
		}
		.buttonStyle(FilterButtonStyle(selected: true))
	}
}
