//
//  AddSongError.swift
//  PedalCore
//
//  Created by Lucas Migge on 15/11/23.
//

import Foundation

enum AddSongError: Error {
    case missingName, missingArtist
    
    var alertDescription: String {
        switch self {
        case .missingName:
            return "Please, provide a name for the song"
        case .missingArtist:
            return "Please, provide the artist name"
        }
    }
    
}
