//
//  CocktailTableViewController.swift
//  BarBook
//
//  Created by Alena Tcareva on 04/09/16.
//  Copyright © 2016 Tony Ganch. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class CocktailTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var cocktails = [Cocktail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedCocktails = loadCocktails() {
            cocktails += savedCocktails
        }
        else {
          // Load the sample data.
          loadSampleCocktails()
        }
        
        indexAllCocktails()
    }
    
    func loadSampleCocktails() {
        let cocktail1 = Cocktail(name: "Aviation", notes: "1.5 oz gin, 0.5 oz marascino, 0.5 oz lemon juice, drop of créme de violette", image: nil)!
        let cocktail2 = Cocktail(name: "Bijou", notes: "", image: nil)!
        let cocktail3 = Cocktail(name: "Gimlet", notes: "", image: nil)!
        
        cocktails += [cocktail1, cocktail2, cocktail3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Indexing
    
    func indexAllCocktails() {
        let searchableItems = cocktails.map { $0.searchableItem }
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems) { error in
            if let error = error {
                NSLog("Error indexing cities: \(error.localizedDescription)")
            }
        }
    }
    
    func cocktailForId(id: String) -> Cocktail? {
        let cocktail = cocktails.filter() {$0.name == id}.first
        return cocktail
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CocktailTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)  as! CocktailTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let cocktail = cocktails[indexPath.row]

        cell.nameField.text = cocktail.name
        cell.imageField.image = cocktail.image
        cell.notesField.text = cocktail.notes

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            cocktails.removeAtIndex(indexPath.row)
            saveCocktails()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let cocktailDetailViewController = segue.destinationViewController as! CocktailViewController
            
            // Get the cell that generated this segue.
            if let selectedCocktailCell = sender as? CocktailTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCocktailCell)!
                let selectedCocktail = cocktails[indexPath.row]
                cocktailDetailViewController.cocktail = selectedCocktail
            }
        }
        else if segue.identifier == "AddItem" {
        }
    }
    
    
    @IBAction func unwindToCocktailList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? CocktailViewController, cocktail = sourceViewController.cocktail {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing coktail.
                cocktails[selectedIndexPath.row] = cocktail
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new cocktail.
                let newIndexPath = NSIndexPath(forRow: cocktails.count, inSection: 0)
                cocktails.append(cocktail)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            saveCocktails()
            indexAllCocktails()
        }
    }

    // MARK: NSCoding
    
    func saveCocktails() {
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cocktails, toFile: Cocktail.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save meals.")
        }
    }
    
    func loadCocktails() -> [Cocktail]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Cocktail.ArchiveURL.path!) as? [Cocktail]
    }
    
}
