//
//  LocalDataProvider.swift
//  PedalCore
//
//  Created by Matheus Berger on 19/12/23.
//

import Foundation

public class PreviewDataProvider<T: Hashable>: DataProviderProtocol {
    public typealias T = T
    
    private(set) public var data: [T] = []
    
    public init() { }
    
    public func update(_ newData: [T]) throws {
        self.data = newData
    }
    
    public func load(_ onLoad: @escaping ([T]) -> Void) throws {
        onLoad([])
    }
}
