//
//  AddSongDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

extension Song {
    protocol EditDelegate: AnyObject {
<<<<<<< HEAD
        func addSong(_ song: Song) async throws
        
        func updateSong(for updatedSong: Song) async throws
=======
        func addSong(_ song: Song) throws
        
        func updateSong(for updatedSong: Song) throws
>>>>>>> main
        
    }
}
