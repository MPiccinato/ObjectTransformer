//
//  APITransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/14/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation
import SwiftyJSON

// Transformers
let kAPITransfomerNSDate = "NSDate"

// Error
enum APITransformerError : ErrorType {
    case Failed
    case NotImplemented
}

// Protocol
protocol APITransformerProtocol {
    
    var manager: APITransformerManager {get}
    
    init(manager: APITransformerManager)
    
    /**
     Map a value to an object
     */
    func map(from: Any?, to: Any?) throws -> AnyObject
    
    /**
     Transform an object into a key/value dictionary to be
     converted to JSON.
     */
    func transform() throws -> [String: AnyObject]
}

// Base
class APITransformer : APITransformerProtocol {
    
    var manager: APITransformerManager
    
    required init(manager: APITransformerManager) {
        self.manager = manager
    }
    
    func transform() throws -> [String: AnyObject]{
        throw APITransformerError.NotImplemented
    }
    
    func map(from: Any?, to: Any?) throws -> AnyObject {
        throw APITransformerError.NotImplemented
    }
}

extension APITransformer {
    func mapValue(value: Any?, transformer: String) -> AnyObject? {
        return self.manager.map(value, transformer: transformer)
    }
    
    func mapDate(string: String?, format: String?) -> NSDate? {
        return self.mapValue(string, transformer: kAPITransfomerNSDate) as? NSDate
    }
    
    func mapArray(array: Array<JSON>?, transformer: String) -> Array<AnyObject> {
        return self.manager.mapArray(array, transformer: transformer)
    }
    
    func mapDictionary(dict: [String: JSON]?, transformer: String) -> Array<AnyObject> {
        return self.manager.mapDictionary(dict, transformer: transformer)
    }
}

