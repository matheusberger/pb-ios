//
//  AddSongDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

protocol AddSongDelegate: AnyObject {
    func addSong(_ song: Song.Model) throws
    
    func updateSong(for updatedSong: Song.Model) throws
    
}
