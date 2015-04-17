//
//  Model.swift
//  ContactViewerWithCoreData
//
//  Created by user27740 on 4/16/15.
//  Copyright (c) 2015 user27740. All rights reserved.
//

import UIKit
import CoreData

@objc(Model)

class Model: NSManagedObject {
    
    @NSManaged var name:String
    @NSManaged var title:String
    @NSManaged var phone:String
    @NSManaged var email:String
    @NSManaged var twitterId:String
    
    
    
    
   
}
