//
//  CocktailViewController.swift
//  BarBook
//
//  Created by Alena Tcareva on 04/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//

import UIKit

class CocktailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties


    @IBOutlet weak var totalVolumeTextField: UITextField!
    @IBOutlet weak var alcoholVolumeTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextView!
    
    
    /*
     This value is either passed by `CocktailTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var cocktail: Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalVolumeTextField.delegate = self
        alcoholVolumeTextField.delegate = self
        ingredientsTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let cocktail = cocktail {
            navigationItem.title = cocktail.name
            totalVolumeTextField.text = cocktail.totalVolume
            alcoholVolumeTextField.text = cocktail.alcoholVolume
            ingredientsTextField.text = cocktail.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

