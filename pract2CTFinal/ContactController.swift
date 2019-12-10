//
//  ContactController.swift
//  pract2CTFinal
//
//  Created by Rasyid Waterkamp on 7/12/19.
//  Copyright © 2019 Rasyid Waterkamp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactController{
    
    func AddContactHeader(contactHeader:ContactHeader){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContactHeader", in: context)!
        let cdContactHeader = NSManagedObject(entity: entity, insertInto: context)
        
        cdContactHeader.setValue(contactHeader.name, forKey: "name")
        cdContactHeader.setValue(contactHeader.email, forKey: "email")

        appDelegate.saveContext()
        
        
    }
    
    func RetrieveContactHeader()->[ContactHeader]{
        var contactHeader:[ContactHeader] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //FETCH contact header
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"CDContactHeader")
        do{
            let cdContactHeader = try context.fetch(fetchRequest) as! [CDContactHeader]
            for r in cdContactHeader{
                contactHeader.append(ContactHeader(name:r.name!, email:r.email!))
            }
        }
        catch{
            print(error)
        }
        
        return contactHeader
    }
    
    func AddNumberToContact(contactHeader:ContactHeader, contactNumber:ContactNumber){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContactNumber", in: context)!
        let cdContactNumber = NSManagedObject(entity: entity, insertInto: context) as! CDContactNumber
        cdContactNumber.number = contactNumber.number
        
        //fetch contact header
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"CDContactHeader")
        fetchRequest.predicate = NSPredicate(format:"email = %@", contactHeader.email!) // means - select*from table where email="email"
        
        do{
            let cdContactHeader = try context.fetch(fetchRequest)
            let temp = cdContactHeader[0] as! CDContactHeader
            cdContactNumber.addToContactHeader(temp)
        }
        catch{
            print(error)
        }
        
        appDelegate.saveContext()
    }
    
    func RetrieveNumberFromContact(contactHeader:ContactHeader) -> [ContactNumber]{
        var contactNumber:[ContactNumber] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"CDContactNumber")

        // if many 2 many
        fetchRequest.predicate = NSPredicate(format: "ANY contactHeader.email = %@", contactHeader.email!)
        
        do{
            let cdContactNumber = try context.fetch(fetchRequest) as! [CDContactNumber]
            for i in cdContactNumber{
                contactNumber.append(ContactNumber(number: i.number!))
            }
        }
        catch{
            print(error)
        }
        
        return contactNumber
    }
    
    func updateContact(newContactHeader:ContactHeader, email:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContactHeader")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)

        do {
            let test = try context.fetch(fetchRequest)

            let objectUpdate = test[0]
            objectUpdate.setValue(newContactHeader.name, forKey: "name")
            objectUpdate.setValue(newContactHeader.email, forKey: "email")

            do{
                try context.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
}
