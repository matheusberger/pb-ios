//
//  KnobViewModel.swift
//  PedalCore
//
//  Created by Lucas Migge on 05/10/23.
//

import Foundation

class KnobViewModel: ObservableObject {
    @Published var dragOffset: CGSize = .zero
    
    @Published var parameter: String
    @Published var level: Float
    
    private let sensitivity: Float = 0.00005
    
    init(knob: Knob) {
        self.parameter = knob.parameter
        self.level = knob.level
    }
    
    
    func dragAction(value: CGSize) {
        level += sensitivity * Float(value.width)
        level -= sensitivity * Float(value.height)
        
        // Limita o valor de level entre 0.0 e 1.0
        level = min(1.0, max(0.0, level))
    }
    
    func dragEnded() {
        dragOffset = .zero
    }
}
