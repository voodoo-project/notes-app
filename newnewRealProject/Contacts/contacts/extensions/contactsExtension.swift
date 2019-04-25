//
//  contactsExtension.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit

extension ContactsVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return getAllContacts().count
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        //let contactsFromPhone = getAllContacts()
        if let contactCell = cell as? ContactCell {
            contactCell.contact = contacts[indexPath.row]
            //contactCell.contact?.name = getAllContacts()
            //contactCell.contact?.name = contactsFromPhone[indexPath.row].givenName
            //contactCell.contact?.someInfo = contactsFromPhone[indexPath.row].familyName
        }
        return cell
    }
    
}
