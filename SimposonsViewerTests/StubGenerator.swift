//
//  StubGenerator.swift
//  SimposonsViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation
@testable import SimposonsViewer

class StubGenerator {
    /** Method to return to us local character mock objects
        */
    func getStub() -> CharactersDictionary? {
        
        let path = Bundle.main.path(forResource: "Simpsons", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(CharactersDictionary.self, from: data)
        } catch { /* Report the decoding error */ print("can't decode Character json data",error) }
        return nil
    }
}
