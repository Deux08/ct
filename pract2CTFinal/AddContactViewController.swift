//
//  AddContactController.swift
//  pract2CTFinal
//
//  Created by Rasyid Waterkamp on 6/12/19.
//  Copyright © 2019 Rasyid Waterkamp. All rights reserved.
//

import Foundation
import UIKit

class AddContactViewController : UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone1: UITextField!
    @IBOutlet weak var txtPhone2: UITextField!
    @IBOutlet weak var txtPhone3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        txtName.text = ""
        txtEmail.text = ""
        txtPhone1.text = ""
        txtPhone2.text = ""
        txtPhone3.text = ""
    }
    
    @IBAction func btnCreate(_ sender: Any) {
        if txtName.text! == "" && txtEmail.text! == "" {
            let alert = UIAlertController(title: "Empty Field", message: "Please populate the name and email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in}))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let contactController:ContactController = ContactController()
            let contactHeader:ContactHeader = ContactHeader(name: txtName.text!, email: txtEmail.text! )
             
            let phone1 = ContactNumber(number: txtPhone1.text!)
            let phone2 = ContactNumber(number: txtPhone2.text!)
            let phone3 = ContactNumber(number: txtPhone3.text!)
            
            let alert = UIAlertController(title: "Create", message: "Are you sure you want to add this contact ?", preferredStyle: .alert)
            
            let addAction = UIAlertAction(title: "Yes", style: .default ) { (action) in
                
                 contactController.AddContactHeader(contactHeader:contactHeader)
                
                 contactController.AddNumberToContact(contactHeader: contactHeader, contactNumber: phone1)
                 contactController.AddNumberToContact(contactHeader: contactHeader, contactNumber: phone2)
                 contactController.AddNumberToContact(contactHeader: contactHeader, contactNumber: phone3)
             }
            let cancelAction = UIAlertAction(title: "No", style: .default , handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            


        }
        
        txtName.text = ""
        txtEmail.text = ""
        txtPhone1.text = ""
        txtPhone2.text = ""
        txtPhone3.text = ""
    }
    
}
