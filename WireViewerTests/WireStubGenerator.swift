//
//  StubGenerator.swift
//  WireViewerTests
//
//  Created by s on 12/18/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation
@testable import WireViewer

class WireStubGenerator {
    /** Method to return to us local character mock objects
        */
    func getStub() -> CharactersDictionary? {
        
        let path = Bundle.main.path(forResource: "Wire", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(CharactersDictionary.self, from: data)
        } catch { /* Report the decoding error */ print("can't decode Character json data",error) }
        return nil
    }
}

