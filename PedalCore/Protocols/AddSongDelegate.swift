//
//  AddSongDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 06/10/23.
//

import Foundation

protocol AddSongDelegate {
    func addSong(name: String, artist: String, pedals: [Pedal])
    
}
