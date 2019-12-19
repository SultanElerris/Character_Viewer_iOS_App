//
//  URLFactory.swift
//  CharacterViewer
//
//  Created by Sultan Sultan on 12/17/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation

struct URLFactory {
    
    /// Base URLS
    internal let charactersBaseURL = "https://api.duckduckgo.com/"

    /// Characters URL Path
    public enum charactersURLPath: String {
       case wire = "?q=the+wire+characters&format=json"
       case simpsons = "?q=simpsons+characters&format=json"
    }
    
    public func getURLForAppType() -> String {
        switch Configuration.CurrentConfigFile.appType {
            case .wire: return charactersBaseURL + charactersURLPath.wire.rawValue
            case .simpsons : return charactersBaseURL + charactersURLPath.simpsons.rawValue
        }
    }
}
