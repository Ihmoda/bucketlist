//
//  addItemTableViewControllerDelegate.swift
//  bucketlist
//
//  Created by Omar Ihmoda on 1/16/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import Foundation

protocol addItemTableViewControllerDelegate: class {
    func itemSaved(by controller: addItemTableViewController, with: String, index: NSIndexPath?)
    func cancelButtonPressed(by controller: addItemTableViewController)
}
