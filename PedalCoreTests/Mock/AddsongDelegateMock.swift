//
//  AddsongDelegateMock.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 16/11/23.
//

import Foundation
@testable import PedalCore

class AddsongDelegateMock: AddSongDelegate {
    
    var didCallAddSong: Bool = false
    var shouldThrowAddSongError: AddSongError?
    
    func addSong(_ song: PedalCore.Song) throws {
        didCallAddSong = true
        
        if let error = shouldThrowAddSongError {
            throw error
        }
    }
    
    func updateSong(for updatedSong: PedalCore.Song) throws {
        
    }
}
