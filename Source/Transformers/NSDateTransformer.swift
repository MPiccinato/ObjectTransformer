//
//  NSDateTransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/18/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

public class NSDateTransformer: Transformer<NSDate, Any> {
    
    public typealias ObjectType = NSDate
    public typealias JSONType = Any
    
    let formatter: NSDateFormatter
    
    public override init() {
        self.formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")
    }
    
    public override func toObject(from: Any) throws -> NSDate {
        
        if let value = from as? String {
            if let date = self.formatter.dateFromString(value) {
                return date
            }
        }
        
        throw TransformerError.Failed
    }
    
    public override func toJSON(object: NSDate?) throws -> Any {
        if let date = object {
            return self.formatter.stringFromDate(date)
        }
        
        throw TransformerError.Failed
    }
}

public class NSDateCustomFormatTransformer: Transformer<NSDate, Any> {
    
    public typealias ObjectType = NSDate
    public typealias JSONType = Any
    
    let formatter: NSDateFormatter
    
    public init(format: String) {
        self.formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(name: "UTC")
    }
    
    public override func toObject(from: Any) throws -> NSDate {
        
        if let value = from as? String {
            if let date = self.formatter.dateFromString(value) {
                return date
            }
        }
        
        throw TransformerError.Failed
    }
    
    public override func toJSON(object: NSDate?) throws -> Any {
        if let date = object {
            return self.formatter.stringFromDate(date)
        }
        
        throw TransformerError.Failed
    }
}

public class NSDateTransformerCustom: Transformer<NSDate, Any> {
    
    public typealias ObjectType = NSDate
    public typealias JSONType = Any
    
    let formatter: NSDateFormatter
    
    public init(formatter: NSDateFormatter) {
        self.formatter = formatter
    }
    
    public override func toObject(from: Any) throws -> NSDate {
        
        if let value = from as? String {
            if let date = self.formatter.dateFromString(value) {
                return date
            }
        }
        
        throw TransformerError.Failed
    }
    
    public override func toJSON(object: NSDate?) throws -> Any {
        if let date = object {
            return self.formatter.stringFromDate(date)
        }
        
        throw TransformerError.Failed
    }
}
