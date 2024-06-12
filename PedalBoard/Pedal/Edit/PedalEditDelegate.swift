//
//  PedalEditDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import Foundation

extension Pedal {
    protocol EditDelegate: AnyObject {
        func finishedEditingPedal(_ pedal: Pedal) throws
        
        func addNewPedal(_ pedal: Pedal) throws
    }
}
