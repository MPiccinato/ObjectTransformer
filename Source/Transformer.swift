//
//  APITransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/14/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

enum TransformerError : ErrorType {
    case Failed
    case NotImplemented
}

protocol TransformerProtocol {
    associatedtype JSONType
    associatedtype ObjectType

    func toObject(_: JSONType, to: ObjectType?) throws -> ObjectType
    func toJSON(_: ObjectType?) throws -> JSONType
    
    static func toObjects<JSONType, ObjectType>(items: Array<JSONType>, transformer: Transformer<JSONType, ObjectType>) -> [ObjectType]
}

extension TransformerProtocol {
    static func toObjects<T, U>(items: Array<T>, transformer: Transformer<T, U>) -> [U] {
        var objects: [U] = []
        for item in items {
            if let object = try? transformer.toObject(item, to: nil) {
                objects.append(object)
            }
        }
        return objects
    }
}

class Transformer<T, U>: TransformerProtocol {
    func toObject(_: T, to: U?) throws -> U {
        throw TransformerError.NotImplemented
    }
    
    func toJSON(_: U?) throws -> T {
        throw TransformerError.NotImplemented
    }
}