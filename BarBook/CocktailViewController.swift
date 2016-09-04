//
//  CocktailViewController.swift
//  BarBook
//
//  Created by Alena Tcareva on 04/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//

import UIKit

class CocktailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    /*
     This value is either passed by `CocktailTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var cocktail: Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        notesTextField.delegate = self
        
        notesTextField.layer.borderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0).CGColor
        notesTextField.layer.borderWidth = 0.5
        notesTextField.layer.cornerRadius = 5.0
        
        // Set up views if editing an existing Meal.
        if let cocktail = cocktail {
            nameTextField.text = cocktail.name
            notesTextField.text = cocktail.notes
            if (cocktail.image != nil) {
              imageView.image = cocktail.image
            }
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidCocktailName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidCocktailName()
    }
    
    func checkValidCocktailName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddCocktailMode = presentingViewController is UINavigationController
        
        if isPresentingInAddCocktailMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let notes = notesTextField.text ?? ""
            let image = imageView.image ?? nil
            cocktail = Cocktail(name: name, notes: notes, image: image)
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}

