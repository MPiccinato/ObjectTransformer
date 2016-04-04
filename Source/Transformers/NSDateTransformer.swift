//
//  NSDateTransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/18/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

struct NSDateTransformer: TransformerProtocol {
    
    typealias ObjectType = NSDate
    typealias JSONType = String
    
    let formatter: NSDateFormatter

    init() {
        self.formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")
    }
    
    func toObject(string: JSONType, to: ObjectType?) throws -> ObjectType {
        if let date = self.formatter.dateFromString(string) {
            return date
        }
        
        throw TransformerError.Failed
    }
    
    func toJSON(object: ObjectType?) throws -> JSONType {
        if let date = object {
            return self.formatter.stringFromDate(date)
        }
        
        throw TransformerError.Failed
    }
}
