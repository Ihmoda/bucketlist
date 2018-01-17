//
//  ViewController.swift
//  bucketlist
//
//  Created by Omar Ihmoda on 1/16/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, addItemTableViewControllerDelegate {
    var bucket_list = [
        "Go to Machu Pichu",
        "See the great awall of China",
        "Go to the Mediterranean",
        "See Home"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.bucket_list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = bucket_list[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "addItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        bucket_list.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is NSIndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
            addItemTableViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = bucket_list[indexPath.row]
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        } else {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
            addItemTableViewController.delegate = self
        }
    }
    
    func cancelButtonPressed(by controller: addItemTableViewController) {
       print("I am the hidden controller")
       dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: addItemTableViewController, with: String, index: NSIndexPath?) {
        if let ip = index {
            bucket_list[ip.row] = with
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        } else {
            print("Received text from topview \(with)")
            bucket_list.append(with)
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    


}

