//
//  APIServiceTests.swift
//  SimposonsViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import XCTest
@testable import SimposonsViewer


class APIServiceTests: XCTestCase {
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
            XCTAssertTrue(charactersDictionary.releatedTopics.first?.text == "Apu Nahasapeemapetilon adfds- Apu Nahasapeemapetilon is a recurring character in the animated TV series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is best known for his catchphrase, \"Thank you, come again.\"")
            expect.fulfill()
        }
    }
    
    func testGetURL() {
        let sut = self.sut!
        
        let urlString = sut.getURL()
        XCTAssertTrue(urlString == "https://api.duckduckgo.com/?q=simpsons+characters&format=json")
    }
}
