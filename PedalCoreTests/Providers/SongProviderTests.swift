//
//  SongProviderTests.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 15/12/23.
//

import XCTest
@testable import PedalCore

final class SongProviderTests: XCTestCase {
    private var provider: SongProvider?

    override func setUpWithError() throws {
        provider = SongProvider()
    }

    func testUpdate() throws {
        let expectedSongs = Song.getSample()
        try provider?.update(expectedSongs)
    }
    
    func testLoad() throws {
        let expectedSongs = Song.getSample()
        try provider?.update(expectedSongs)
        try provider?.load{ songs in
            XCTAssert(songs.count == expectedSongs.count)
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
