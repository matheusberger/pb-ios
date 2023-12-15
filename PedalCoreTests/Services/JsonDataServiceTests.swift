//
//  JsonDataServiceTests.swift
//  PedalCoreTests
//
//  Created by Matheus Berger on 13/12/23.
//

import XCTest
import PedalCore

final class JsonDataServiceTests: XCTestCase {
    
    private let fileName = "TestFile"
    private var service: JsonDataService<Song>?
    private var loadedSongs: [Song] = []

    override func setUpWithError() throws {
        service = JsonDataService<Song>(fileName: fileName)
    }
    
    func testSaveSongsToTestFile() throws {
        let songs = Song.getSample()
        try service?.save(songs)
    }
    
    func testLoadSongsFromTestFile() throws {
        try testSaveSongsToTestFile()
        try service?.load { songs in
            let expectedSongs = Song.getSample()
            XCTAssert(songs.count == expectedSongs.count)
            loadedSongs = songs
            // XCTAssert(songs.contains(expectedSongs)) // only available in iOS > 16
        }
    }
    
    func testDeleteSingleSongFromTestFile() throws {
        try testLoadSongsFromTestFile()
        
        let _ = loadedSongs.removeFirst()
        XCTAssert(loadedSongs.count == 1)
        try service?.save(loadedSongs)
    }
    
    func testCorrectSongCountAfterDeletion() throws {
        try testDeleteSingleSongFromTestFile()
        try service?.load { songs in
            XCTAssert(songs.count == 1)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
