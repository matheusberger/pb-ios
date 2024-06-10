//
//  AddSongDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

extension Song {
    protocol EditDelegate: AnyObject {
        func addSong(_ song: Song.Model) throws
        
        func updateSong(for updatedSong: Song.Model) throws
        
    }
}
