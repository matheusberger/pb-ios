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
        // This id is necessary to make it Hashable
        private var id: UUID = UUID()
        
        var editPedal: Pedal
        
        @Published var pedalName: String
        @Published var brandName: String
        @Published var knobs: [Pedal.Knob] = []
        
        @Published var isPresentingAlert: Bool = false
        @Published var alertMessage: String = ""
        
        private let onSave: (_ pedal: Pedal) -> Void
        
        init(_ pedal: Pedal? = nil, _ onSave: @escaping (_ pedal: Pedal) -> Void) {
            self.onSave = onSave
            
            self.editPedal = pedal ?? Pedal.emptyPedal()
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
        
        public func save() async {
            do {
                let pedal = Pedal(id: editPedal.id, name: self.pedalName, brand: self.brandName, knobs: self.knobs)
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

/// Hashable extension to enable navigation view NavigationLink(value:)
extension Pedal.EditViewModel: Hashable {
    static func == (lhs: Pedal.EditViewModel, rhs: Pedal.EditViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
