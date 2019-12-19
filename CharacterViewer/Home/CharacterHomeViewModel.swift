//
//  HomeViewModel.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/15/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation

protocol CharacterViewModelDelegateProtocol: class {
    func didUpdateData()
}

class CharacterHomeViewModel: NSObject {
    // This property is a dependency of CharacterHomeViewModel. It takes care of all the networking work and provide
    // a mumber of methods to get data. For our app, we can use it to fetch data from extenal server and to inject a mock object
    // when we do testing.
    let apiService: APIServiceProtocol
    // An array that holds a list of characters.
    var charactersArray = [Character]() {
        didSet {
            filterCharacters(searchText: latestSearchText)
        }
    }
    // An array that holds a list of characters tht we filtered when we start searching
    var filteredCharactersArray = [Character]()
    // a var to hold the latest search text
    private var latestSearchText: String = ""
    
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    //private let networkManager = NetworkManager.sharedInstance
    weak var delegate: CharacterViewModelDelegateProtocol?
    
    /**
     Method to fetch characters from external server.
     */
    func fetchAllCharacters()  {
        let factory = URLFactory()
        apiService.fetchCharactersDictFrom(url: factory.getURLForAppType(), cache: true, completion: { [weak self] (charactersDictionary) in  
            self?.charactersArray = charactersDictionary.releatedTopics
        })
    }
    
    func filterCharacters(searchText: String) {
        latestSearchText = searchText
        filteredCharactersArray = searchText.isEmpty ? charactersArray : charactersArray.filter({ (character: Character) -> Bool in
            return character.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        delegate?.didUpdateData()
    }
}
