//
//  ItemDetailViewController.swift
//  Scavenger Hunt
//
//  Created by Alejandrina Patron on 9/25/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemNameStr: String?
    var itemImage: UIImage?
    var currentItem: ScavengerHuntItem?
    var sourceViewController: ListViewController? // implement
    var selectedPath: NSIndexPath? // implement
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!

    override func viewDidLoad() {
        if let theSourceViewController = sourceViewController, theChosenPath = selectedPath {
            itemNameStr = theSourceViewController.myManager.items[theChosenPath.row].name
            if let unwrappedName = itemNameStr {
                itemNameLabel.text = "Item: \(unwrappedName)"
            }
            itemImageView.image = theSourceViewController.myManager.items[theChosenPath.row].photo
        }
        super.viewDidLoad()
    }
    
    @IBAction func itemFound(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
//        itemImageView.image = photo
//        currentItem!.photo = photo
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let theSourceViewController = sourceViewController, theChosenPath = selectedPath {
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            itemImageView.image = photo
            theSourceViewController.myManager.items[theChosenPath.row].photo = photo
            theSourceViewController.tableView.reloadRowsAtIndexPaths([theChosenPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            theSourceViewController.myManager.save()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
