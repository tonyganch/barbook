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
    
    var id: String
    var name: String // Aviation
    var keywords: Array<String>!
    var description: String // 4.5 cl gin
    var searchDescription: String
    var totalVolume: String // 75 ml
    var alcoholVolume: String // 10 ml
    var alcoholPercentage: String // 5%
    

    // MARK: Initialization
    init?(data: NSDictionary!) {
        self.id = data.objectForKey("id") as! String
        self.name = data.objectForKey("name") as! String
        self.keywords = data.objectForKey("keywords") as! Array<String>
        self.description = data.objectForKey("ingredients") as! String
        self.searchDescription = data.objectForKey("searchDescription") as! String
        self.totalVolume = data.objectForKey("totalVolume") as! String
        self.alcoholVolume = data.objectForKey("alcoholVolume") as! String
        self.alcoholPercentage = data.objectForKey("abv") as! String
        
    }

    
    // MARK: Search
        
    var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = name
        attributeSet.contentDescription = searchDescription
        attributeSet.keywords = keywords
        return attributeSet
    }
    
    var searchableItem: CSSearchableItem {
        let item = CSSearchableItem(uniqueIdentifier: id,
                                    domainIdentifier: "com.example.BarBook.cocktail",
                                    attributeSet: attributeSet)
        return item
    }
 
}