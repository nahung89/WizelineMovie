//
//  ChallengeModelTests.swift
//  ChallengeTests
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

@testable import Challenge
import XCTest

class ChallengeModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRecipesDecode() throws {
        let data = """
            {
                "page": 1,
                "total_results": 6910,
                "total_pages": 346,
                "results": []
            }
        """.data(using: .utf8)!

        let movieList = try JSONDecoder().decode(MovieList.self, from: data)

        XCTAssertEqual(movieList.page, 1)
        XCTAssertEqual(movieList.totalPages, 346)
        XCTAssertEqual(movieList.totalResults, 6910)
        XCTAssertEqual(movieList.movies.count, 0)
        debugPrint(movieList)
    }

    func testMovieDecode() throws {
        let data = """
             {
                "vote_count": 1978,
                "id": 19404,
                "video": false,
                "vote_average": 9.1,
                "title": "Dilwale Dulhania Le Jayenge",
                "popularity": 16.603,
                "poster_path": "/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",
                "original_language": "hi",
                "original_title": "दिलवाले दुल्हनिया ले जायेंगे",
                "genre_ids": [35, 18, 10749 ],
                "backdrop_path": "/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",
                "adult": false,
                "overview": "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
                "release_date": "1995-10-20"
            }
        """.data(using: .utf8)!

        let movie = try JSONDecoder().decode(Movie.self, from: data)

        XCTAssertEqual(movie.title, "Dilwale Dulhania Le Jayenge")
        XCTAssertEqual(movie.id, 19404)
        XCTAssertEqual(movie.voteAverage, 9.1)
        debugPrint(movie)
    }
}
