//
//  addItemTableViewController.swift
//  bucketlist
//
//  Created by Omar Ihmoda on 1/16/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit

class addItemTableViewController: UITableViewController {
    
    var item: String?
    var indexPath: NSIndexPath?
    weak var delegate: addItemTableViewControllerDelegate?
    
    @IBOutlet weak var textItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textItem.text = item

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        print("add Item hit")
        let text = textItem.text!
        delegate?.itemSaved(by: self, with: text, index: self.indexPath)
    }
    


}
