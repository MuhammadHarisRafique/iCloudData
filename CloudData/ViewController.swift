//
//  ViewController.swift
//  CloudData
//
//  Created by Higher Visibility on 13/01/2018.
//  Copyright © 2018 Higher Visibility. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {

    let database = CKContainer.default().privateCloudDatabase

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }

    @IBAction func add_item(_ sender: UIBarButtonItem) {
        
        self.showalertView()
        
    }
    func saveToCloud(value:String){
        let dic = ["ac":3.0]
        let record = CKRecord(recordType: "TestDatabase2")
        record.setValue(value, forKey: "SMS")
    
        
        database.save(record) { (rec, error) in
            if let err = error{
            print(err.localizedDescription)
            
            }else{
                
                print(rec!.value(forKey: "SMS")!)
                print(rec!.value(forKey: "dic")!)
                print("save sucessfully")
                
            }
        }
    }
    func queryDatabase(){
        
        let query = CKQuery(recordType: "TestDatabase", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (rec, error) in
            
            if error == nil{
        
                for item in rec!{
                    
                    print(item.value(forKey: "Message")!)
                    
                }
         
            }else{
            print(error!.localizedDescription)
        }
        }
        
    }
    func showalertView(){
        
        let alertScreen = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let addaction = UIAlertAction(title: "Save", style: .default) { (acttion) in
            let texboxText = alertScreen.textFields?.first?.text!
            print(texboxText!)
           self.saveToCloud(value: texboxText!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (acttion) in
            self.queryDatabase()
        }
        alertScreen.addTextField { (textbox) in
            
            textbox.placeholder = "write something"
            
            
        }
        alertScreen.addAction(addaction)
        alertScreen.addAction(cancel)
        self.present(alertScreen, animated: true, completion: nil)
        
    }
}

