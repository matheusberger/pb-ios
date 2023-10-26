//
//  AddPedalDelegate.swift
//  PedalCore
//
//  Created by Lucas Migge on 02/10/23.
//

import Foundation

protocol AddPedalDelegate {
    func addPedalPressed(name: String, brand: String, knobNames: [String]) throws
}
