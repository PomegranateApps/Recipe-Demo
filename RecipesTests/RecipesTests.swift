//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Chris DeSalvo on 11/20/2024.
//

import Testing
import XCTest
import Foundation
@testable import Recipes

final class RecipesTests: XCTestCase {
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testFetchRecipesSuccess() async throws {
		let recipes = try await RecipeService.fetch(from: .valid)
		XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty")
	}
}
