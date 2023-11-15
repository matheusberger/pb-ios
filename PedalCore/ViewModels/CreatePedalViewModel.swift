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
    
    weak var delegate: CreatePedalDelegate?
    
    public var style: Style {
        if editePedal != nil {
            return .editPedal
        } else {
            return .createPedal
        }
    }
    
    init(delegate: CreatePedalDelegate? = nil, editPedal: Pedal? = nil) {
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
            self.knobNames = []
        }
        
    }
    
    public func addKnobPressed() {
        knobNames.append("")
    }
    
    public func removeKnob(at offSets: IndexSet) {
        knobNames.remove(atOffsets: offSets)
    }
    
    public func doneButtonPressed() {
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
            alertMessage = pedalError.description
        }

    }
}
