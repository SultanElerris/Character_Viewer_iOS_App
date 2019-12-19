//
//  WireDetailsViewModelTests.swift
//  WireViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import XCTest
@testable import WireViewer

var detailsviewModel: DetailsViewModel?

class DetailsViewModelTests: XCTestCase {

    override func setUp() {
        detailsviewModel = DetailsViewModel()
    }

    override func tearDown() {
        detailsviewModel = nil
    }

    func testGetWireCharacterName() {
        let stubGenerator = WireStubGenerator()
        let wireMock = stubGenerator.getStub()

        XCTAssertTrue(wireMock?.releatedTopics.first?.text == "Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.")
        XCTAssertTrue(detailsviewModel?.getCharacterName(from: wireMock?.releatedTopics.first?.text ?? "")  == "Alma Gutierrez ")
        XCTAssertFalse(detailsviewModel?.getCharacterName(from: wireMock?.releatedTopics.first?.text ?? "")  == "Chief Wiggum ")
        XCTAssertTrue(detailsviewModel?.getCharacterDescription(from: wireMock?.releatedTopics.first?.text ?? "")  == "Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.")
    }
}
