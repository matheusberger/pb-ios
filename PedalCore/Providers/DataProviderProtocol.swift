//
//  DataProviderProtocol.swift
//  PedalCore
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation

public protocol DataProviderProtocol<T> {
    associatedtype T
    
    var data: [T] { get }
    
    func update(_: [T]) throws
    func load(_: @escaping (_: [T]) -> Void) throws
}
