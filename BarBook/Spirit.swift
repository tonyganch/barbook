//
//  Spirit.swift
//  BarBook
//
//  Created by Alena Tcareva on 09/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//


import UIKit

class Spirit {
    // MARK: Properties
    
    var id: String
    var name: String // Aviation
    var alcoholPercentage: Int!
    
 
    // MARK: Initialization
    init?(data: NSDictionary!) {
        self.id = data.objectForKey("id") as! String
        self.name = data.objectForKey("name") as! String
        self.alcoholPercentage = data.objectForKey("alcoholPercentage") as! Int
    }
}