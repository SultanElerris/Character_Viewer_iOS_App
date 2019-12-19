//
//  Configuration.swift
//  CharacterViewer
//
//  Created by Sultan Sultan on 12/17/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation

struct Configuration {
  enum AppType: String { 
      case wire = "Wire"
      case simpsons = "Simpsons"
    }
    
    /// An enum to get the current app from plist file . E.X, Wire, Simpsons
    public enum CurrentConfigFile {
        
      private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
          fatalError("Plist file not found")
        }
        return dict
      }()

     static let appType: AppType = {
        guard let appTypeString = CurrentConfigFile.infoDictionary["AppType"] as? String else {
          fatalError("App Type not set in plist for this scheme")
        }

        guard let appType = AppType.init(rawValue: appTypeString) else {
            fatalError()
        }

        return appType
      }()
    }
}
