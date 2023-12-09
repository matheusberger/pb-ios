//
//  PersistenceProtocol.swift
//  PedalCore
//
//  Created by Matheus Berger on 07/12/23.
//

import Foundation

protocol PersistenceProtocol<T> {
    associatedtype T
    
    func save() throws
    func load(onLoad: (_: [T]) -> Void) throws
    func update(_: [T])
}
