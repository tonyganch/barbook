//
//  Cocktail.swift
//  BarBook
//
//  Created by Alena Tcareva on 04/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class Cocktail {
    // MARK: Properties
    var name: String // Aviation
    var notes: String? // 4.5 cl gin
    var totalVolume: String? // 75 ml
    var alcoholVolume: String? // 10 ml
    var alcoholPercentage: String? // 5%
    
    init?(name: String, notes: String?="", totalVolume: String?="", alcoholVolume: String?="", alcoholPercentage: String?="") {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.notes = notes
        self.totalVolume = totalVolume
        self.alcoholVolume = alcoholVolume
        self.alcoholPercentage = alcoholPercentage
    }
    
    
    init?(data: NSDictionary!) {
        let name = data.objectForKey("name") as! String
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.notes = data.objectForKey("notes") as? String
        self.totalVolume = data.objectForKey("totalVolume") as? String
        self.alcoholVolume = data.objectForKey("alcoholVolume") as? String
        self.alcoholPercentage = data.objectForKey("alcoholPercentage") as? String
    }

    
    // MARK: Search
    
    /*
    var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = name
        attributeSet.contentDescription = notes
        attributeSet.keywords = [name]
        if (image != nil) {
            attributeSet.thumbnailData = UIImagePNGRepresentation(image!)
        }
        return attributeSet
    }
    
    var searchableItem: CSSearchableItem {
        let item = CSSearchableItem(uniqueIdentifier: name,
                                    domainIdentifier: "com.example.BarBook.cocktail",
                                    attributeSet: attributeSet)
        return item
    }
    */
}