//
//  PedalCreationDelegateMock.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import Foundation
@testable import PedalBoard

class PedalCreationDelegateMock: Pedal.EditDelegate {
    var didCallFinishedEditingPedal: Bool = false
    var finishedEditingPedalShouldThrowError: Pedal.EditError? = nil
    
    var didCallAddNewPedal: Bool = false
    var addNewPedalShouldThrowError: Pedal.EditError? = nil
    
    func finishedEditingPedal(_ pedal: Pedal) throws {
        didCallFinishedEditingPedal = true
        if let error = finishedEditingPedalShouldThrowError {
            throw error
        }
    }
    
    func addNewPedal(_ pedal: Pedal) throws {
        didCallAddNewPedal = true
        if let error = addNewPedalShouldThrowError {
            throw error
        }
    }
    
}
