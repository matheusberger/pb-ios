//
//  SongListViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import XCTest
import PedalCore
@testable import PedalBoard

#warning("Create mocks to replace preview")
final class SongViewModelTests: XCTestCase {
    
    var viewModel: Song.ListViewModel!

    @MainActor override func setUpWithError() throws {
        viewModel = Song.ListViewModel(songProvider: PreviewDataProvider(), pedalProvider: PreviewDataProvider())
        
    }

    @MainActor func testViewModelEmptyStateWhenHasNoSongs() {
        XCTAssertTrue(viewModel.state == .empty)
    }
    
    @MainActor func testViewModelContentStateWhenHasSongs() {
        viewModel.allSongs = Song.getSample()
        
        XCTAssertTrue(viewModel.state == .content)
    }
    
    @MainActor func testViewModelStartsWithEmptySearchText() {
        XCTAssertTrue(viewModel.searchText.isEmpty)
    }
    
    @MainActor func testDeleteSongRemovesItFromSongsArray() {
        let song1 = Song(name: "test1", artist: "test1", pedals: [])
        let song2 = Song(name: "test2", artist: "test2", pedals: [])
        let song3 = Song(name: "test3", artist: "test3", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel.allSongs = songsArray
        
        viewModel.deleteSong(song1)
        
        XCTAssertFalse(viewModel.allSongs.contains(song1))
        XCTAssertTrue(viewModel.allSongs.contains(song2))
        XCTAssertTrue(viewModel.allSongs.contains(song3))
        
    }

    @MainActor func testSearchFilterSelectsSongsBySongName() {
        let song1 = Song(name: "505", artist: "Arctic Monkeys", pedals: [])
        let song2 = Song(name: "Arrabela", artist: "Arctic Monkeys", pedals: [])
        let song3 = Song(name: "Reckoner", artist: "Radiohead", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel.allSongs = songsArray
        
        viewModel.searchText = "rec"
        
        XCTAssertFalse(viewModel.songs.contains(song1))
        XCTAssertFalse(viewModel.songs.contains(song2))
        XCTAssertTrue(viewModel.songs.contains(song3))
    }
    
    @MainActor func testNoSongsFilterWhenSearchSearachFilterIsEmpty() {
        let song1 = Song(name: "505", artist: "Arctic Monkeys", pedals: [])
        let song2 = Song(name: "Arrabela", artist: "Arctic Monkeys", pedals: [])
        let song3 = Song(name: "Reckoner", artist: "Radiohead", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel.allSongs = songsArray
        
        viewModel.searchText = ""
        
        XCTAssertTrue(viewModel.songs.contains(song1))
        XCTAssertTrue(viewModel.songs.contains(song2))
        XCTAssertTrue(viewModel.songs.contains(song3))
    }
    
    @MainActor func testAddSongWithValidInfoAppendsToAllSongsArray() {
        let song = Song(name: "505", artist: "Arctic Monkeys", pedals: [])
        
        viewModel.allSongs.append(song)
        XCTAssertTrue(viewModel.allSongs.contains(song))
    }
}


