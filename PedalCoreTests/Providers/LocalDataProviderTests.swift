//
//  LocalDataProviderTests.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 19/12/23.
//

import XCTest
@testable import PedalBoard
@testable import PedalCore

final class LocalDataProviderTests: XCTestCase {
    
    private var provider: LocalDataProvider<Song.Model>?

    override func setUpWithError() throws {
        let persistance = MockPersistanceService<Song.Model>(fileName: "TestingFile")
        provider = LocalDataProvider<Song.Model>(persistence: persistance)
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
    
    func testSavingError() throws {
        let persistance = MockPersistanceService<Song.Model>(fileName: "TestingFile", shouldThrowSaving: true)
        provider = LocalDataProvider<Song.Model>(persistence: persistance)
        
        XCTAssertThrowsError(try provider?.update([]))
    }
    
    func testLoadingError() throws {
        let persistance = MockPersistanceService<Song.Model>(fileName: "TestingFile", shouldThrowLoading: true)
        provider = LocalDataProvider<Song.Model>(persistence: persistance)
        
        XCTAssertThrowsError(try provider?.load({ _ in /*do nothing*/ }))

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
