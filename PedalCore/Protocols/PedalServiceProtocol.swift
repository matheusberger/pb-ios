//
//  PedalServiceProtocol.swift
//  PedalCore
//
//  Created by Lucas Migge on 21/11/23.
//

import Foundation

protocol PedalServiceProtocol {
    func editPedal(for pedal: Pedal)
    
    func editPedalCanceled()
    
    func populatePedal()
    
    func getUserPedals() -> [Pedal]
    
    func subscribeToPedalUpdates(observer: PedalDataObserver)
    
    func removePedal(for removedPedal: Pedal)
}
