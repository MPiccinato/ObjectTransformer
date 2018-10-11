//
//  NSDateTransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/18/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

open class NSDateTransformer: Transformer<Date, String> {
    
    public typealias ObjectType = Date
    public typealias JSONType = Any
    
    public enum DateFormat: String {
        case ISO8601Full    = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case RSS            = "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case AltRSS         = "d MMM yyyy HH:mm:ss ZZZ"
        case Extended       = "eee dd-MMM-yyyy GG HH:mm:ss.SSS ZZZ"
    }
    
    let formatter: DateFormatter
    
    public init(format: String? = DateFormat.ISO8601Full.rawValue) {
        self.formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "UTC")
    }
    
    open override func toObject(_ from: String?) throws -> Date {
        
        if let value = from {
            if value.characters.count > 0 {
                if let date = self.formatter.date(from: value) {
                    return date
                }
            }
        }
        
        throw TransformerError.failed
    }
    
    open override func toJSON(_ object: Date?) throws -> String {
        if let date = object {
            return self.formatter.string(from: date)
        }
        
        throw TransformerError.failed
    }
}

open class NSDateTransformerCustom: Transformer<Date, Any> {
    
    public typealias ObjectType = Date
    public typealias JSONType = Any
    
    let formatter: DateFormatter
    
    public init(formatter: DateFormatter) {
        self.formatter = formatter
    }
    
    open override func toObject(_ from: Any) throws -> Date {
        
        if let value = from as? String {
            if let date = self.formatter.date(from: value) {
                return date
            }
        }
        
        throw TransformerError.failed
    }
    
    open override func toJSON(_ object: Date?) throws -> Any {
        if let date = object {
            return self.formatter.string(from: date)
        }
        
        throw TransformerError.failed
    }
}
