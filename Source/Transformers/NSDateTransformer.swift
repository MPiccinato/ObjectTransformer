//
//  NSDateTransformer.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/18/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation

import SwiftDate

class NSDateTransformer : APITransformer {
    
    lazy var formatter: NSDateFormatter = {
        [unowned self] in
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")
       
        return formatter
    }()
    
    override func map(from: Any?, to: Any?) throws -> AnyObject {

        if let string = from as? String {
            // Default
            if let date = self.formatter.dateFromString(string) {
                return date
            }
            else if let date = NSDate.date(fromString: string, format: DateFormat.ISO8601){
                return date
            }
        }
        
        throw APITransformerError.Failed
    }
}
