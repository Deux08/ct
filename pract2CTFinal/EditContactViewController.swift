//
//  EditContactViewController.swift
//  pract2CTFinal
//
//  Created by Rasyid Waterkamp on 8/12/19.
//  Copyright © 2019 Rasyid Waterkamp. All rights reserved.
//

import Foundation
import UIKit

class EditContactViewController : UIViewController {
    
    @IBOutlet weak var txtEditName: UITextField!
    @IBOutlet weak var txtEditEmail: UITextField!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    
//    var getName = String()
//    var getEmail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contactHeaderList = ContactController().RetrieveContactHeader()
        let contactHeader = contactHeaderList[AppDelegate.temp]

        txtEditName.text = contactHeader.name
        txtEditEmail.text = contactHeader.email

        
//        txtEditName.placeholder = getName
//        txtEditEmail.placeholder = getEmail
    }
    
    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        let contactHeaderList = ContactController().RetrieveContactHeader()
        let oldContact = contactHeaderList[AppDelegate.temp]
        
        let contactHeader:ContactHeader = ContactHeader(name: String(txtEditName.text!), email: String(txtEditEmail.text!))
        
        ContactController().updateContact(newContactHeader: contactHeader, email: String(txtEditEmail.text!))
    }
    
}
