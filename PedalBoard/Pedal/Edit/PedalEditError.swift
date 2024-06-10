//
//  PedalEditError.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import Foundation

extension Pedal {
    enum EditError: Error {
        case missingName, missingBrand, missingKnobs, missingKnobName
        
        var description: String {
            switch self {
            case .missingName:
                return "Please, provide the pedal name"
            case .missingBrand:
                return "Please, provide a brand for your pedal"
            case .missingKnobs:
                return "Please, provide a knob name for your pedal"
            case .missingKnobName:
                return "One of the knobs has no name. Please provide one or removed it"
            }
        }
    }
}
