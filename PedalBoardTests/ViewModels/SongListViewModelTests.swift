//
//  SongListViewModelTests.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import XCTest
import PedalCore
@testable import PedalBoard

final class SongViewModelTests: XCTestCase {
    
    var viewModel: Song.List.ViewModel!

    override func setUpWithError() throws {
        viewModel = Song.List.ViewModel()
        
    }

    func testViewModelEmptyStateWhenHasNoSongs() {
        let persistance = JsonDataService<Song.Model>(fileName: "SongsViewModelTests")
        let provider = LocalDataProvider<Song.Model>(persistence: persistance)
        viewModel = Song.List.ViewModel(songProvider: provider)
        
        XCTAssertTrue(viewModel.state == .empty)
    }
    
    func testViewModelContentStateWhenHasSongs() {
        viewModel = Song.List.ViewModel()
        viewModel.allSongs = Song.getSample()
        
        XCTAssertTrue(viewModel.state == .content)
    }
    
    func testViewModelStartsWithEmptySearchText() {
        
        XCTAssertTrue(viewModel.searchText.isEmpty)
    }
    
    func testDeleteSongRemovesItFromSongsArray() {
        let song1 = Song.Model(name: "test1", artist: "test1", pedals: [])
        let song2 = Song.Model(name: "test2", artist: "test2", pedals: [])
        let song3 = Song.Model(name: "test3", artist: "test3", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel = Song.List.ViewModel()
        viewModel.allSongs = songsArray
        
        viewModel.deleteSong(song1)
        
        XCTAssertFalse(viewModel.allSongs.contains(song1))
        XCTAssertTrue(viewModel.allSongs.contains(song2))
        XCTAssertTrue(viewModel.allSongs.contains(song3))
        
    }

    func testSearchFilterSelectsSongsBySongName() {
        let song1 = Song.Model(name: "505", artist: "Arctic Monkeys", pedals: [])
        let song2 = Song.Model(name: "Arrabela", artist: "Arctic Monkeys", pedals: [])
        let song3 = Song.Model(name: "Reckoner", artist: "Radiohead", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel = Song.List.ViewModel()
        viewModel.allSongs = songsArray
        
        viewModel.searchText = "rec"
        
        XCTAssertFalse(viewModel.songs.contains(song1))
        XCTAssertFalse(viewModel.songs.contains(song2))
        XCTAssertTrue(viewModel.songs.contains(song3))
    }
    
    func testNoSongsFilterWhenSearchSearachFilterIsEmpty() {
        let song1 = Song.Model(name: "505", artist: "Arctic Monkeys", pedals: [])
        let song2 = Song.Model(name: "Arrabela", artist: "Arctic Monkeys", pedals: [])
        let song3 = Song.Model(name: "Reckoner", artist: "Radiohead", pedals: [])
        let songsArray = [song1, song2, song3]
        viewModel = Song.List.ViewModel()
        viewModel.allSongs = songsArray
        
        viewModel.searchText = ""
        
        XCTAssertTrue(viewModel.songs.contains(song1))
        XCTAssertTrue(viewModel.songs.contains(song2))
        XCTAssertTrue(viewModel.songs.contains(song3))
    }
    
    func testAddSongButtonPresentsSheets() {
        viewModel.isShowingSheet = false
        
        viewModel.addSongPressed()
        
        XCTAssertTrue(viewModel.isShowingSheet)
    }
    
    func testAddSongWithValidInfoAppendsToAllSongsArray() {
        let song = Song.Model(name: "505", artist: "Arctic Monkeys", pedals: [])
        
        try? viewModel.addSong(song)
        
        XCTAssertTrue(viewModel.allSongs.contains(song))
        
    }
    
    
    func testAddsongWithInvalidInfoThrowsError() {
        
        let song = Song.Model(name: "", artist: "Arctic Monkeys", pedals: [])
        
        XCTAssertThrowsError(try viewModel.addSong(song))
        
    }
    
    func testAddSongWithNoNameThrowsRelatedAddSongError() {
        
        let song = Song.Model(name: "", artist: "Arctic Monkeys", pedals: [])
        
        do {
            try viewModel.addSong(song)
        } catch {
            if let addSongError = error as? AddSongError {
                XCTAssertTrue(addSongError == .missingName)
            }
        
        }
    }
    
    func testAddSongWithNoArtistThrowsRelatedAddSongError() {
        
        let song = Song.Model(name: "Teddy Picker", artist: "", pedals: [])
        
        do {
            try viewModel.addSong(song)
        } catch {
            if let addSongError = error as? AddSongError {
                XCTAssertTrue(addSongError == .missingArtist)
            }
        }
    }
}


