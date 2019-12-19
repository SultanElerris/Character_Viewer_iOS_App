//
//  APIServiceTests.swift
//  WireViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import XCTest
@testable import WireViewer

class WireAPIServiceTests: XCTestCase {
    var sut: APIService?

    override func setUp() {
        super.setUp()
        sut = APIService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCharacter() {
           
        let expect = XCTestExpectation(description: "callback")
        // Given A apiservice
        let sut = self.sut!
        sut.fetchCharactersDictFrom(url: nil, cache: true) { (charactersDictionary: CharactersDictionary) in
            XCTAssertTrue(charactersDictionary.releatedTopics.first?.text == "Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.")
           
            expect.fulfill()
        }
    }
    
    func testGetURL() {
        let sut = self.sut!
        
        let urlString = sut.getURL()
        XCTAssertTrue(urlString == "https://api.duckduckgo.com/?q=the+wire+characters&format=json")
    }
}
