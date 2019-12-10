//
//  ShowContactViewController.swift
//  pract2CTFinal
//
//  Created by Rasyid Waterkamp on 6/12/19.
//  Copyright © 2019 Rasyid Waterkamp. All rights reserved.
//

import Foundation
import UIKit

class ShowContactViewController: UITableViewController {

    var contactHeader:[ContactHeader] = []
    var contactNumber:[ContactNumber] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contactController:ContactController = ContactController()
        contactHeader = contactController.RetrieveContactHeader()
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contactHeader = ContactController().RetrieveContactHeader()
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        if let carts = UserDefaults.standard.array(forKey: "cartt") as? [[String: Any]] {
//            loadedCart = carts
//        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactHeader.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let contactController:ContactController = ContactController()
            contactNumber = contactController.RetrieveNumberFromContact(contactHeader: contactHeader[indexPath.row])

            cell.textLabel?.text = "\(contactHeader[indexPath.row].name!) - \(contactHeader[indexPath.row].email!)"
                
            var text = ""
            
            for i in contactNumber{
                if i.number == ""{
                    text += ""
                }
                else{
                    text += "[\(String(describing: i.number!))] "
                }
                
            }
            
        cell.detailTextLabel?.text = text
            
            return cell
        }
    
     override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                    
            let contactController:ContactController = ContactController()
            contactNumber = contactController.RetrieveNumberFromContact(contactHeader: contactHeader[indexPath.row])
            
            let editAction = UITableViewRowAction(style: .default, title: "Edit"){(action, indexPath) in
    //            self.updateAction(contact: contact, indexPath: indexPath)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let editVC = storyBoard.instantiateViewController(withIdentifier: "editPage") as! EditContactViewController
                self.present(editVC, animated: true, completion: nil)
            }
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(action, indexPath) in
    //            self.deleteAction(contact: contact, indexPath: indexPath)
            }
            
            deleteAction.backgroundColor = .red
            editAction.backgroundColor = .blue
            return [deleteAction, editAction]
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        AppDelegate.temp = Int(indexPath.row)
    }
}
