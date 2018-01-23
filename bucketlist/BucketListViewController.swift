//
//  ViewController.swift
//  bucketlist
//
//  Created by Omar Ihmoda on 1/16/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, addItemTableViewControllerDelegate {
    
    var bucket_list = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                if let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    let result = jsonResult as! [NSDictionary]
                    for task in result {
                        if let item = task["objective"] {
                            let text = item as! String
                            let new_record = BucketListItem(context: self.managedObjectContext)
                            new_record.text = text
                            self.bucket_list.append(new_record)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } else {
                    print("Hello")
                }
            } catch {
                print("Something went wrong")
            }
        }
        super.viewDidLoad()
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
        
        cell.textLabel?.text = bucket_list[indexPath.row].text!
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "addItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = bucket_list[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        bucket_list.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is NSIndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
            addItemTableViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = bucket_list[indexPath.row].text!
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
            bucket_list[ip.row].text! = with
        } else {
            print("Received text from topview \(with)")
            
            //old way of creating a new object
            //let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            
            let item = BucketListItem(context: managedObjectContext)
            item.text = with
            bucket_list.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllItems() {
        
        
        //let thingRequest:NSFetchRequest<Thing> = Thing.fetchRequest()
        //do { let fetchedThings = try context.fetch(thingRequest) }
        //catch { print(error) }
        
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        let request: NSFetchRequest<BucketListItem> = BucketListItem.fetchRequest()

        do {
            let result = try self.managedObjectContext.fetch(request)
                self.bucket_list = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
        
    }
    
    


}

