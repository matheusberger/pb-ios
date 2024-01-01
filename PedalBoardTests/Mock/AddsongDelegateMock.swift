//
//  AddsongDelegateMock.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import Foundation
@testable import PedalBoard

class AddsongDelegateMock: AddSongDelegate {
    
    var didCallAddSong: Bool = false
    var shouldThrowAddSongError: AddSongError?
    
    func addSong(_ song: Song.Model) throws {
        didCallAddSong = true
        
        if let error = shouldThrowAddSongError {
            throw error
        }
    }
    
    func updateSong(for updatedSong: Song.Model) throws {
        didCallAddSong = true
        
        if let error = shouldThrowAddSongError {
            throw error
        }
    }
}
