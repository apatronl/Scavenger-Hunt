//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UINavigationControllerDelegate {

    let myManager = ItemsManager()
    var itemNameToPass: String!
    var itemPhotoToPass: UIImage?
    
//    override func viewWillAppear(animated: Bool) {
//        self.tableView.reloadData()
//        myManager.save()
//    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem {
                myManager.items += [newItem]
                myManager.save()
                let indexPath = NSIndexPath(forRow: myManager.items.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        let item = myManager.items[indexPath.row]
        
        if item.isComplete {
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        cell.textLabel?.text = item.name
        
        return cell
        
    }
        
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "DetailView" {
//            let destinationVC = segue.destinationViewController as! ItemDetailViewController
//            if let selectedItem = sender as? UITableViewCell {
//                let indexPath = tableView.indexPathForCell(selectedItem)
//                let item = myManager.items[indexPath!.row]
//                itemNameToPass = item.name
//                itemPhotoToPass = item.photo
//                destinationVC.itemNameStr = itemNameToPass
//                destinationVC.itemImage = itemPhotoToPass
//                destinationVC.currentItem = item // CHECK
//            }
//        }
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailView" {
            if let selectedItem = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(selectedItem)
                let destinationVC = segue.destinationViewController as! ItemDetailViewController
                destinationVC.sourceViewController = self
                destinationVC.selectedPath = indexPath
            }
        }
    }
}