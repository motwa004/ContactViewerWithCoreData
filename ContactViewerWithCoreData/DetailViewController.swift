//
//  DetailViewController.swift
//  ContactViewerWithCoreData
//
//  Created by user27740 on 4/16/15.
//  Copyright (c) 2015 user27740. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!

    @IBOutlet weak var txtTitle: UITextField!
    
    
    @IBOutlet weak var txtPhone: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtTwitterId: UITextField!
    
    
    var cname: String = ""
    var ctitle: String = ""
    var cphone: String = ""
    var cemail: String = ""
    var ctwitterId: String = ""
    
    var existingItem:NSManagedObject!
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
    if (existingItem != nil) {
    
        txtName.text = cname
        txtTitle.text = ctitle
        txtPhone.text = cphone
        txtEmail.text = cemail
        txtTwitterId.text = ctwitterId
        
        
    }
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contxt)
        
        if (existingItem != nil) {
            
            existingItem.setValue(txtName.text as String, forKey: "name")
            existingItem.setValue(txtTitle.text as String, forKey: "title")
            existingItem.setValue(txtPhone.text as String, forKey: "phone")
            existingItem.setValue(txtEmail.text as String, forKey: "email")
            existingItem.setValue(txtTwitterId.text as String, forKey: "twitterId")
        
        } else {
            
        var newItem = Model(entity: en!, insertIntoManagedObjectContext:contxt)
        
        newItem.name = txtName.text
        newItem.title = txtTitle.text
        newItem.phone = txtPhone.text
        newItem.email = txtEmail.text
        newItem.twitterId = txtTwitterId.text
            
        println(newItem)
            
        }
        
        contxt.save(nil)
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

