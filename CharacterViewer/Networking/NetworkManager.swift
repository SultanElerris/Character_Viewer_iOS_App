//
//  NetworkManager.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/15/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func getURL() -> String
    func fetchCharactersDictFrom(url: String?, cache: Bool, completion: @escaping (_ dictionary: CharactersDictionary) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchCharactersDictFrom(url: String?, cache: Bool, completion: @escaping (_ dictionary: CharactersDictionary) -> Void) {
        
        // No URL, no point of proceeding so early exit
        guard let url = url else{
            return
        }
        // Request data from Almo
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            
            switch response.result {
            case .success(let payload):
                do {
                    let charactersDictionary = try JSONDecoder().decode(CharactersDictionary.self, from: payload)
                    completion(charactersDictionary)
                } catch let error {
                    print("Parsing failed with error: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func getURL() -> String {
        let factory = URLFactory()
        return (factory.getURLForAppType())
    }
}

