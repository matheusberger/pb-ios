//
//  CreatePedalViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 18/10/23.
//

import Foundation

class CreatePedalViewModel: ObservableObject {
    
    enum Style {
        case editPedal, createPedal
    }
    
    var editePedal: Pedal?
    
    @Published var pedalName: String
    @Published var brandName: String
    @Published var knobNames: [String] = []
    
    @Published var isPresentingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var delegate: AddPedalDelegate?
    
    var style: Style {
        if editePedal != nil {
            return .editPedal
        } else {
            return .createPedal
        }
    }
    
    init(delegate: AddPedalDelegate? = nil, editPedal: Pedal? = nil) {
        self.delegate = delegate
        
        if let pedal = editPedal {
            self.editePedal = pedal
            self.pedalName = pedal.name
            self.brandName = pedal.brand
            pedal.knobs.forEach { knob in
                self.knobNames.append(knob.name)
            }
        } else {
            self.pedalName = ""
            self.brandName = ""
        }
        
    }
    
    
    func addKnobPressed() {
        knobNames.append("")
    }
    
    
    func doneButtonPressed() {
        switch style {
        case .editPedal:
            editPedalDone()
        case .createPedal:
            addNewPedal()
        }
    }
    
    func addNewPedal() {
        do {
            
            let pedal = Pedal(name: self.pedalName, brand: self.brandName, knobs: createKnobs())
            try delegate?.addNewPedal(pedal)
            
        } catch {
         
            dealWithErrors(error: error)
        }
    }
    
    func editPedalDone() {
        do {
            guard let oldPedal = editePedal else { return }
        
            let pedal = Pedal(id: oldPedal.id, name: self.pedalName, brand: self.brandName, knobs: createKnobs())
            try delegate?.finishedEditingPedal(pedal)
            
        } catch {
            dealWithErrors(error: error)
        }

    }
    
    private func createKnobs() -> [Knob] {
        return knobNames.map { Knob(name: $0) }
    }
    
    private func dealWithErrors(error: Error) {
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
