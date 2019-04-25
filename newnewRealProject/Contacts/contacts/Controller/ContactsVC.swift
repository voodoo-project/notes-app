//
//  ViewController.swift
//  newRealProject
//
//  Created by Захар  Сегал on 13/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import Contacts

import UIKit

class ContactsVC: UITableViewController {
    
    //MARK: Properties
    let model = ContactListModel()
    var contacts:[ContactsModel] = []
    var localContacts = [LocalContact]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        model.retreiveContacts { [weak self] contacts in
            self?.contacts = contacts
            self?.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let contactProfile = segue.destination as? ContactsProfileVC {
            let row = tableView.indexPathForSelectedRow?.row
            contactProfile.profile = contacts[row!]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllContacts()
        
        
//        let contactsFromPhone = getAllContacts()
//        for contactFromPhone in contactsFromPhone {
//            print("\(contactFromPhone.givenName)")
//        }
    }
    
    
    //MARK: Contacts:
    private func getAllContacts() /*-> [CNContact]*/ {
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("Failed to Request Access", error)
                return
            }
            if granted {
                print("access granted")
                let keys = [CNContactGivenNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        print(contact.givenName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                        self.localContacts.append(LocalContact(name: contact.givenName, phone: contact.phoneNumbers.first?.value.stringValue ?? "" ))
                    })
                } catch let error{
                    print("Failed to enumerate contacts:",error )
                }
            }
            else{
                print("access denied")
            }
        }  
    }
    
    
    //MARK: Alert
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                print("Ok button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
