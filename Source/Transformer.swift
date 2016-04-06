//
//  APITransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/14/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

public enum TransformerError : ErrorType {
    case Failed
    case NotImplemented
}

public protocol TransformerProtocol {
    associatedtype JSONType
    associatedtype ObjectType
    
    func toObject(_: JSONType) throws -> ObjectType
    func toJSON(_: ObjectType?) throws -> JSONType
    
    func toObjects(items: [JSONType]?) throws -> [ObjectType]
}

extension TransformerProtocol {
    public func toObjects(items: [JSONType]?) throws -> [ObjectType] {
        guard items != nil else {
            throw TransformerError.Failed
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

public class Transformer<T, U>: TransformerProtocol {
    
    public init() { }
    
    public func toObject(_: U) throws -> T {
        throw TransformerError.NotImplemented
    }
    
    public func toJSON(_: T?) throws -> U {
        throw TransformerError.NotImplemented
    }
}