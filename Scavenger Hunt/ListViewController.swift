//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let myManager = ItemsManager()
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.items[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
            dismissViewControllerAnimated(true, completion: { () -> Void in self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
}