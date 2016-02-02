//
//  APITransformManager.swift
//  StockX
//
//  Created by Piccinato, Mathew on 11/16/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 Manage Transformers
 
 Add each transformer that conforms to APITransformerProtocol here to allow for
 object mapping.
 
 This object is meant to be copied with each payload processing request. Each
 trasnformer object will receive a shared copy across the lifetime of the payload
 being processed.
 
 Transformers are only init'd once accessed and then cached.
 
 Use with an asynchronous network request! Why thread if you have already threaded dog?
 */
class APITransformerManager {
    
    var transformers: [String:AnyObject] = [:]
    
    init() {
    
    }
   
    /**
        Map an arbitrary JSON payload to objects. Main entry point.
   
        - Parameter json: The JSON Object
     
        - Returns: Array of AnyObject
     */
    func map(json: JSON) -> Dictionary<String, Any> {
        
        var results = Dictionary<String, Any>()
       
        for (key, subJSON):(String, JSON) in json {
            // Array
            if subJSON.type == SwiftyJSON.Type.Array {
                var arr: Array<Any> = []
                for sub in subJSON.arrayValue {
                    if let obj = self.map(sub, transformer: key) {
                        arr.append(obj)
                    }
                }
                results[key] = arr
            }
            // Object
            else if let obj = self.map(subJSON, transformer: key) {
                results[key] = obj
            }
        }
        
        return results
    }
   
    /**
        Searches the transformer with the given key and maps
        the object.
     
        - Parameter json: JSON
        - Parameter using: String
        
        - Returns: AnyObject
    */
    func map(value: Any?, transformer: String) -> AnyObject? {
        if let transformer = self.transformerForKey(transformer) {
            return try? transformer.map(value, to: nil)
        }
        return nil
    }
    
    func mapDictionary(dict: [String: JSON]?, transformer: String) -> Array<AnyObject> {
        guard dict != nil else {
            return []
        }
        
        var objects: Array<AnyObject> = []
        
        for(_, value) in dict! {
            if let object = self.map(value, transformer: transformer) {
                objects.append(object)
            }
        }
        return objects
    }
    
    func mapArray(array: Array<JSON>?, transformer: String) -> Array<AnyObject> {
        guard array != nil else {
            return []
        }
        
        var objects: Array<AnyObject> = []
        
        for value in array! {
            if let object = self.map(value, transformer: transformer) {
                objects.append(object)
            }
        }
        return objects
    }
   
    /**
        Adds the transformer to the internal dictionary on the key provided by the
        transformer. A plural is automatically added; 'Product' & 'Products'.
  
        - Parameter key: String key
        - Parameter type: APITransformer.Type
     */
    func addTransformerForKey(key: String, type: APITransformer.Type) {
        self.transformers[key] = type
    }
   
    /**
        Fetch a transformer for the given key.
     
        - Parameter key: String
    
        - Returns: AnyObject conforming to the APITransformerProtocol
     */
    func transformerForKey(key: String) -> APITransformer? {
        var transformer = self.transformers[key]
        
        if transformer is APITransformer.Type {
            transformer = (transformer as! APITransformer.Type).init(manager: self)
            self.transformers[key] = transformer
        }
        
        return transformer as? APITransformer
    }
}