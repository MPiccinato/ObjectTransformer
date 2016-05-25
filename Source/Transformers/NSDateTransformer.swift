//
//  NSDateTransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/18/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

public class NSDateTransformer: Transformer<NSDate, String> {
    
    public typealias ObjectType = NSDate
    public typealias JSONType = Any
    
    public enum DateFormat: String {
        case ISO8601Full    = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case RSS            = "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case AltRSS         = "d MMM yyyy HH:mm:ss ZZZ"
        case Extended       = "eee dd-MMM-yyyy GG HH:mm:ss.SSS ZZZ"
    }
    
    let formatter: NSDateFormatter
    
    public init(format: String? = DateFormat.ISO8601Full.rawValue) {
        self.formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(name: "UTC")
    }
    
    public override func toObject(from: String?) throws -> NSDate {
        
        if let value = from {
            if value.characters.count > 0 {
                if let date = self.formatter.dateFromString(value) {
                    return date
                }
            }
        }
        
        throw TransformerError.Failed
    }
    
    public override func toJSON(object: NSDate?) throws -> String {
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
