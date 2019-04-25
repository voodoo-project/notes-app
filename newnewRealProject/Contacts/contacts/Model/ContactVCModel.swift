//
//  ContactVCModel.swift
//  newRealProject
//
//  Created by Захар  Сегал on 14/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import CoreData
import Contacts

struct ContactList: Codable {
    let contacts:[ContactsModel]
}

struct ContactsModel: Codable {
    var name,someInfo:String?
    var image:URL?
    var userId:Int?
}

struct ErrorResponse : Codable {
    var name,message,type:String?
    var code,status:Int?
}

struct LocalContact {
    var name:String?
    var phone:String?
}


class ContactListModel {
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "contactList")
        container.loadPersistentStores(completionHandler: { (store, error) in
            
        })
        return container
    }()
    
//    func getAllContacts() -> [CNContact] {
//
//        let contacts: [CNContact] = {
//            let contactStore = CNContactStore()
//            let keysToFetch = [
//                //CNContactGivenNameKey,
//                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
//                CNContactEmailAddressesKey,
//                CNContactPhoneNumbersKey,
//                CNContactImageDataAvailableKey,
//                CNContactThumbnailImageDataKey] as [Any]
//
//            var allContainers: [CNContainer] = []
//            do {
//                allContainers = try contactStore.containers(matching: nil)
//            } catch {
//
//            }
//
//            var results: [CNContact] = []
//
//            for container in allContainers {
//                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
//
//                do {
//                    let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
//                    results.append(contentsOf: containerResults)
//                } catch {
//
//                }
//            }
//
//            return results
//        }()
//
//        return contacts
//    }
    
    func retreiveContacts(completion: @escaping ([ContactsModel]) -> ()) {
        
        let params = ["name":"ContactList"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        
        let store = UserDefaults.standard
        let key = "contactListCache"
        if let data = store.value(forKey: key) as? Data {
            let contactList = try? JSONDecoder().decode(ContactList.self, from: data)
            completion((contactList?.contacts)!)
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard  let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if  let data = data,
                let httpResponse = response as? HTTPURLResponse,
                error == nil,
                httpResponse.statusCode ==  200 {
                guard let contactList = try? JSONDecoder().decode(ContactList.self, from: data) else {
                    print("error decoding Contacts")
                    return
                }
                if let data = try? JSONEncoder().encode(contactList) {
                        UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(contactList.contacts)
                }
            }
                
            else {
                let describingError = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
                print(describingError ?? "error describing error")
                print(httpBody)
                print(response ?? "error response")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
}

