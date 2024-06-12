//
//  PedalEditViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 18/10/23.
//

import Foundation
import PedalCore

extension Pedal {
    class EditViewModel: ObservableObject {
        
        enum Style {
            case editPedal, createPedal
        }
        
        var editPedal: Pedal?
        
        @Published var pedalName: String
        @Published var brandName: String
        @Published var knobs: [Pedal.Knob] = []
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        private let onSave: (_ pedal: Pedal) -> Void
        
        public var style: Style {
            if editPedal != nil {
                return .editPedal
            } else {
                return .createPedal
            }
        }
        
        init(_ editPedal: Pedal? = nil, _ onSave: @escaping (_ pedal: Pedal) -> Void) {
            self.onSave = onSave
            
            guard let editPedal else {
                self.pedalName = ""
                self.brandName = ""
                self.knobs = []
                return
            }
            
            self.editPedal = editPedal
            self.pedalName = editPedal.name
            self.brandName = editPedal.brand
            self.knobs = editPedal.knobs
        }
        
        public func addKnobPressed() {
            knobs.append(Pedal.Knob(name: ""))
        }
        
        @MainActor
        public func removeKnob(at offSets: IndexSet) {
            guard let index = offSets.first else { return }
            if index < knobs.count {
                self.knobs.remove(atOffsets: offSets)
            }
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
                let pedal = Pedal(name: self.pedalName, brand: self.brandName, knobs: self.knobs)
                try validadePedalInfo(pedal)
                
                onSave(pedal)
            } catch {
                handleError(error: error)
            }
        }
        
        func editPedalDone() {
            do {
                guard let oldPedal = editPedal else { return }
            
                let pedal = Pedal(id: oldPedal.id, name: self.pedalName, brand: self.brandName, knobs: self.knobs)
                try validadePedalInfo(pedal)
 
                onSave(pedal)
            } catch {
                handleError(error: error)
            }
        }
        
        private func validadePedalInfo(_ pedal: Pedal) throws {
            if pedal.name.isEmpty {
                throw Pedal.EditError.missingName
            }
            
            if pedal.brand.isEmpty {
                throw Pedal.EditError.missingBrand
            }
            
            if pedal.knobs.isEmpty {
                throw Pedal.EditError.missingKnobs
            }
            
            try pedal.knobs.forEach { knob in
                if knob.name.isEmpty {
                    throw Pedal.EditError.missingKnobName
                }
            }
        }
        
        private func handleError(error: Error) {
            if let pedalError = error as? Pedal.EditError {
                isPresentingAlert = true
                alertMessage = pedalError.description
            }

        }
    }
}
