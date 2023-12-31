//
//  PedalCreationDelegateMock.swift
//  PedalCoreTests
//
//  Created by Lucas Migge on 14/11/23.
//

import Foundation
@testable import PedalBoard

class PedalCreationDelegateMock: PedalCreationDelegate {
    var didCallFinishedEditingPedal: Bool = false
    var finishedEditingPedalShouldThrowError: AddPedalError? = nil
    
    var didCallAddNewPedal: Bool = false
    var addNewPedalShouldThrowError: AddPedalError? = nil
    
    func finishedEditingPedal(_ pedal: Pedal.Model) throws {
        didCallFinishedEditingPedal = true
        if let error = finishedEditingPedalShouldThrowError {
            throw error
        }
    }
    
    func addNewPedal(_ pedal: Pedal.Model) throws {
        didCallAddNewPedal = true
        if let error = addNewPedalShouldThrowError {
            throw error
        }
    }
    
}
