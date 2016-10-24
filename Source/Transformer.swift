//
//  APITransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/14/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

public enum TransformerError : Error {
    case failed
    case notImplemented
}

public protocol TransformerProtocol {
    associatedtype JSONType
    associatedtype ObjectType
    
    func toObject(_: JSONType) throws -> ObjectType
    func toJSON(_: ObjectType?) throws -> JSONType
    
    func toObjects(_ items: [JSONType]?) throws -> [ObjectType]
}

extension TransformerProtocol {
    public func toObjects(_ items: [JSONType]?) throws -> [ObjectType] {
        guard items != nil else {
            throw TransformerError.failed
        }
        
        var objects: [ObjectType] = []
        for item in items! {
            if let object = try? self.toObject(item) {
                objects.append(object)
            }
        }
        return objects
    }
}

open class Transformer<T, U>: TransformerProtocol {
    
    public init() { }
    
    open func toObject(_: U) throws -> T {
        throw TransformerError.notImplemented
    }
    
    open func toJSON(_: T?) throws -> U {
        throw TransformerError.notImplemented
    }
}
