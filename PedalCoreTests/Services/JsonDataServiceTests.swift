//
//  JsonDataServiceTests.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 13/12/23.
//

import XCTest
@testable import PedalBoard
@testable import PedalCore

final class JsonDataServiceTests: XCTestCase {
    
    private let fileName = "TestFile"
    private var service: JsonDataService<Song.Model>?

    override func setUpWithError() throws {
        service = JsonDataService<Song.Model>(fileName: fileName)
    }
    
    func testSaveSongsToTestFile() throws {
        let songs = Song.getSample()
        try service?.save(songs)
    }
    
    func testLoadSongsFromTestFile() throws {
        let expectedSongs = Song.getSample()
        
        try service?.save(expectedSongs)
        try service?.load { songs in
            XCTAssert(songs.count == expectedSongs.count)
            // XCTAssert(songs.contains(expectedSongs)) // only available in iOS > 16
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
