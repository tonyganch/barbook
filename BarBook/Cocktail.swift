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

class Cocktail: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var notes: String?
    var image: UIImage?
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let notesKey = "notes"
        static let imageKey = "image"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("cocktails")
    
    // MARK: Initialization
    
    init?(name: String, notes: String?, image: UIImage?) {
        self.name = name
        self.notes = notes
        self.image = image
        
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as? String
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        self.init(name: name, notes: notes, image: image)
    }
    
    // MARK: Search
    
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
}