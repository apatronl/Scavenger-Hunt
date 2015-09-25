//
//  ItemsManager.swift
//  Scavenger Hunt
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import UIKit

class ItemsManager {
    var items = [ScavengerHuntItem]()
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/ScavengerHuntItems"
        }
        assertionFailure("Could not determine where to save file.")
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if NSKeyedArchiver.archiveRootObject(items, toFile: theArchivePath) {
                print("We saved!")
            } else {
                assertionFailure("Could not save to \(theArchivePath)")
            }
        }
    }
    
    func unarchivedSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                items = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
    init() {
        unarchivedSavedItems()
    }
}
