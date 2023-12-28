//
//  PersistenceProtocol.swift
//  PedalCore
//
//  Created by Matheus Berger on 07/12/23.
//

import Foundation

public protocol PersistenceProtocol<T> {
    associatedtype T where T: Hashable
    
    func save(_: [T]) throws
    func load(_: (_: [T]) -> Void) throws
}
