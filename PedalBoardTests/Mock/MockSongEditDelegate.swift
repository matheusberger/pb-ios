//
//  AddsongDelegateMock.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import Foundation
@testable import PedalBoard

class MockSongEditDelegate: Song.EditDelegate {
    
    var didCallAddSong: Bool = false
    var shouldThrowAddSongError: Song.EditError?
    
    func addSong(_ song: Song) throws {
        didCallAddSong = true
        
        if let error = shouldThrowAddSongError {
            throw error
        }
    }
    
    func updateSong(for updatedSong: Song) throws {
        didCallAddSong = true
        
        if let error = shouldThrowAddSongError {
            throw error
        }
    }
}
