//
//  AddSongDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

protocol AddSongDelegate: AnyObject {
    func addSong(name: String, artist: String, pedals: [Pedal]) throws
    
}
