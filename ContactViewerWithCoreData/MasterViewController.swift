//
//  MasterViewController.swift
//  ContactViewerWithCoreData
//
//  Created by user27740 on 4/16/15.
//  Copyright (c) 2015 user27740. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController{

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var myList : Array<AnyObject> = []

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func viewDidAppear(animated: Bool) {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "List")
        myList = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {

    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier? == "update" {
            
            var srow: NSIndexPath = self.tableView.indexPathForSelectedRow()!
         var selectedItem: NSManagedObject = myList[srow.row] as NSManagedObject
            

            let IVC: DetailViewController = segue.destinationViewController as DetailViewController
            
            IVC.cname = selectedItem.valueForKeyPath("name") as String
            IVC.ctitle = selectedItem.valueForKeyPath("title") as String
            IVC.cphone = selectedItem.valueForKeyPath("phone") as String
            IVC.cemail = selectedItem.valueForKeyPath("email") as String
            IVC.ctwitterId = selectedItem.valueForKeyPath("twitterId") as String
            IVC.existingItem = selectedItem
            
        }
        
    }

    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID:NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        
        //if let ip = indexPath {
        var data: NSManagedObject = myList[indexPath.row] as NSManagedObject
            cell.textLabel?.text = data.valueForKeyPath("name") as? String
            var titl = data.valueForKeyPath("title") as String
            
            cell.detailTextLabel?.text = "\(titl)"
       // }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == .Delete {
            
           // if let tv = tableView {
                
            context.deleteObject(myList[indexPath.row] as NSManagedObject)
            
            myList.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Fade)
                
            //}
        }
            var error: NSError? = nil
            if !context.save(&error) {
                
                abort()
                
            }
        
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {

    }

  
}

