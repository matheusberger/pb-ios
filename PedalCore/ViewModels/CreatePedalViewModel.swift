//
//  CreatePedalViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 18/10/23.
//

import Foundation

class CreatePedalViewModel: ObservableObject {
    @Published var pedalName: String = ""
    @Published var brandName: String = ""
    @Published var knobNames: [String] = []
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var delegate: AddPedalDelegate?
    
    init(delegate: AddPedalDelegate? = nil) {
        self.delegate = delegate
    }
    
    
    func addKnobPressed() {
        knobNames.append("")
    }
    
    func addPedalPressed() {
        do {
            try delegate?.addPedalPressed(name: pedalName, brand: brandName, knobNames: knobNames)
            
        } catch {
            if let pedalError = error as? AddPedalError {
                isPresentingAlert = true
                switch pedalError {
                case .missingName:
                   alertMessage = "Please, provide the pedal name"
                case .missingBrand:
                    alertMessage = "Please, provide a brand of the pedal"
                case .missingKnobs:
                    alertMessage = "Please, provide a knob name for your pedal"
                }
            }
        }

    }
}
