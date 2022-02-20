//
//  PeopleViewModelTests.swift
//
//
//  Created by Chris on 20/02/2022.
//

@testable import DirectoryAPI
import XCTest

class PeopleViewModelTests: XCTestCase {
    var peopleViewModel: PeopleViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        peopleViewModel = PeopleViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test API fetch, ideally this should be decoupled from the backend server
    /// so changes/avaliability of the server do not affec tthe outcome of the test
    func testFetchAPI() throws {
        // Create an expectation
        let expectation = self.expectation(description: "test expectation")

        peopleViewModel.updateDataHandler = {
            expectation.fulfill()
        }

        peopleViewModel.searchText = "@"

        // Wait for the expectation to be fulfilled, or time out
        // after x seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertEqual(peopleViewModel.people.count, 65)
    }
}
