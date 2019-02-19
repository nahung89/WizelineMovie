//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

@testable import Challenge
import XCTest

class ChallengeTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipesDecode() throws {
        let data = """
            {
                "count": 3,
                "recipes": [
                {
                "publisher": "Closet Cooking",
                "f2f_url": "http://food2fork.com/view/35382",
                "title": "Jalapeno Popper Grilled Cheese Sandwich",
                "source_url": "http://www.closetcooking.com/2011/04/jalapeno-popper-grilled-cheese-sandwich.html",
                "recipe_id": "35382",
                "image_url": "http://static.food2fork.com/Jalapeno2BPopper2BGrilled2BCheese2BSandwich2B12B500fd186186.jpg",
                "social_rank": 100.0,
                "publisher_url": "http://closetcooking.com"
                },
                {
                "publisher": "The Pioneer Woman",
                "f2f_url": "http://food2fork.com/view/47024",
                "title": "Perfect Iced Coffee",
                "source_url": "http://thepioneerwoman.com/cooking/2011/06/perfect-iced-coffee/",
                "recipe_id": "47024",
                "image_url": "http://static.food2fork.com/icedcoffee5766.jpg",
                "social_rank": 100.0,
                "publisher_url": "http://thepioneerwoman.com"
                },
                {
                "publisher": "The Pioneer Woman",
                "f2f_url": "http://food2fork.com/view/47319",
                "title": "Crash Hot Potatoes",
                "source_url": "http://thepioneerwoman.com/cooking/2008/06/crash-hot-potatoes/",
                "recipe_id": "47319",
                "image_url": "http://static.food2fork.com/CrashHotPotatoes5736.jpg",
                "social_rank": 100.0,
                "publisher_url": "http://thepioneerwoman.com"
                }]
            }
        """.data(using: .utf8)!

        let recipes = try JSONDecoder().decode(Recipes.self, from: data)

        XCTAssertEqual(recipes.count, 3)
        XCTAssertEqual(recipes.recipes[0].id, "35382")
        XCTAssertEqual(recipes.recipes[1].imageUrl, URL(string: "http://static.food2fork.com/icedcoffee5766.jpg")!)
        XCTAssertEqual(recipes.recipes[2].socialRank, 100.0)
        debugPrint(recipes)
    }

    func testRecipeDecode() throws {
        let data = """
        {
            "publisher": "Two Peas and Their Pod",
            "f2f_url": "http://food2fork.com/view/975e33",
            "title": "No-Bake Chocolate Peanut Butter Pretzel Cookies",
            "source_url": "http://www.twopeasandtheirpod.com/no-bake-chocolate-peanut-butter-pretzel-cookies/",
            "recipe_id": "975e33",
            "image_url": "http://static.food2fork.com/NoBakeChocolatePeanutButterPretzelCookies44147.jpg",
            "social_rank": 99.999,
            "publisher_url": "http://www.twopeasandtheirpod.com"
        }
        """.data(using: .utf8)!

        let recipe = try JSONDecoder().decode(Recipe.self, from: data)

        XCTAssertEqual(recipe.title, "No-Bake Chocolate Peanut Butter Pretzel Cookies")
        XCTAssertEqual(recipe.id, "975e33")
        XCTAssertEqual(recipe.url, URL(string: "http://food2fork.com/view/975e33")!)
        XCTAssertEqual(recipe.socialRank, 99.999)
        debugPrint(recipe)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
