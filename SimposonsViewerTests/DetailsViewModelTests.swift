//
//  DetailsViewModelTests.swift
//  SimposonsViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import XCTest
@testable import SimposonsViewer

var detailsviewModel: DetailsViewModel?

class DetailsViewModelTests: XCTestCase {

    override func setUp() {
        detailsviewModel = DetailsViewModel()
    }

    override func tearDown() {
        detailsviewModel = nil
    }

    func testGetSimpsonCharacterName() {
        let stubGenerator = StubGenerator()
        let simpsonsMock = stubGenerator.getStub()
        

        XCTAssertTrue(simpsonsMock?.releatedTopics.first?.text == "Apu Nahasapeemapetilon - Apu Nahasapeemapetilon is a recurring character in the animated TV series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is best known for his catchphrase, \"Thank you, come again.\"")
        
        XCTAssertTrue(detailsviewModel?.getCharacterName(from: simpsonsMock?.releatedTopics.first?.text ?? "")  == "Apu Nahasapeemapetilon ")
        
        XCTAssertFalse(detailsviewModel?.getCharacterName(from: simpsonsMock?.releatedTopics.first?.text ?? "")  == "Chief Wiggum ")
        
         XCTAssertTrue(detailsviewModel?.getCharacterDescription(from: simpsonsMock?.releatedTopics.first?.text ?? "")  == "Apu Nahasapeemapetilon - Apu Nahasapeemapetilon is a recurring character in the animated TV series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is best known for his catchphrase, \"Thank you, come again.\"")
      
    }
}
