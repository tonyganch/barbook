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
import Realm
import RealmSwift


func getData() -> Array<Cocktail>! {
    let path = NSBundle.mainBundle().pathForResource("BarBookData", ofType: "json")
    let jsonData = try! NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
    let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
    let loadedCocktails : [NSDictionary] = (jsonResult["cocktails"] as? [NSDictionary])!
    return loadedCocktails.map({
        Cocktail(data: $0)!
    })
}

class CocktailTableViewController: UITableViewController {
    // MARK: Properties
    
    let cocktails = getData()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexAllCocktails()
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
        let cocktail = cocktails.filter() {$0.id == id}.first
        return cocktail
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(cocktails.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CocktailTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)  as! CocktailTableViewCell
        
        let cocktail = cocktails[indexPath.row] 
        
        cell.nameField.text = cocktail.name
        
        cell.notesField.text = cocktail.notes
        
        if cocktail.totalVolume != nil && cocktail.alcoholVolume != nil {
            cell.volumeField.text = "\(cocktail.totalVolume ?? "")/\(cocktail.alcoholVolume ?? "")"
        }
        
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
            // cocktails.removeAtIndex(indexPath.row)
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let cocktailVC = segue.destinationViewController as! CocktailViewController
            
            // Get the cell that generated this segue.
            if let selectedCocktailCell = sender as? CocktailTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCocktailCell)!
                let selectedCocktail = cocktails[indexPath.row]
                cocktailVC.cocktail = selectedCocktail as! Cocktail
            }
        }
    }

    
}
