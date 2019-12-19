//
//  CharacterHomeViewModelTest.swift
//  SimposonsViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import XCTest
@testable import SimposonsViewer


class FakeAPIService: APIServiceProtocol {
    func fetchCharactersDictFrom(url: String?, cache: Bool, completion: @escaping (_ dictionary: CharactersDictionary) -> Void) {
        if let dict = StubGenerator().getStub() {
            
            let randomWaitingPeriod: TimeInterval = TimeInterval(arc4random() % 1000) / 500
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + randomWaitingPeriod) {
                completion(dict)
            }
        }
    }
    
    func getURL() -> String {
        return "fakeapi"
    }
}

class FakeCharacterHomeViewController: CharacterViewModelDelegateProtocol {
    var completion: (() -> Void)?
    func didUpdateData() {
        completion?()
    }
    
}

class CharacterHomeViewModelTest: XCTestCase {
    
    private var viewModel: CharacterHomeViewModel?
    private var fakeCharacterHomeViewController: FakeCharacterHomeViewController?
    private var fakeAPIService: FakeAPIService?
    
    override func setUp() {
        let fakeAPIService = FakeAPIService()
        self.fakeAPIService = fakeAPIService
        viewModel = CharacterHomeViewModel(apiService: fakeAPIService)
        fakeCharacterHomeViewController = FakeCharacterHomeViewController()
        viewModel?.delegate = fakeCharacterHomeViewController
    }
    
    override func tearDown() {
        viewModel = nil
        fakeAPIService = nil
        fakeCharacterHomeViewController = nil
    }
    
    func testFiltering() {
        
        let searchText = "Apu"
        
        let expect = XCTestExpectation(description: "CharacterHomeViewModelTest.testFiltering.callback")
        
        // Order of execution: E1, E2, E3, ...
        
        // E1 - we assign the completion handler
        fakeCharacterHomeViewController?.completion = { [weak self] in
            // E3
            
            self?.fakeCharacterHomeViewController?.completion = {
                // E5
                
                XCTAssertEqual(self?.viewModel?.filteredCharactersArray.first?.name, "Apu Nahasapeemapetilon")
                XCTAssertNotNil(self?.viewModel?.filteredCharactersArray.first?.name == "Waylon Smithers", "first name in the array of filtered names should be 'Apu Nahasapeemapetilon'")
                XCTAssertEqual(self?.viewModel?.filteredCharactersArray.first?.text, "Apu Nahasapeemapetilon - Apu Nahasapeemapetilon is a recurring character in the animated TV series The Simpsons. He is an Indian immigrant proprietor who runs the Kwik-E-Mart, a popular convenience store in Springfield, and is best known for his catchphrase, \"Thank you, come again.\"")
                
               

                expect.fulfill()
            }
            // E4
            self?.viewModel?.filterCharacters(searchText: searchText)
        }
        // E2 - view model with fetch all characters from the fake API, some delay will happen
        viewModel?.fetchAllCharacters()
        wait(for: [expect], timeout: 10.0)
    }
}
