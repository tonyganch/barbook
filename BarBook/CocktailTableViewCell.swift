//
//  CocktailTableViewCell.swift
//  BarBook
//
//  Created by Alena Tcareva on 04/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var volumeField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
