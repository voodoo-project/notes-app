//
//  ProfileRelationsContactsModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 11/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

struct RelationsContactsModel:Codable{
    var relationContacts:[RelationContact]
}

struct RelationContact:Codable {
    var imageURL:URL?
    var name:String?
    var info:String?
}

class ContactsRelationsInfo{
    
}


class ContactsRelations{
    
    func retreiveInfo(completion: @escaping ([RelationContact]) -> ()) {
        
        let params = ["name":"PofileRelationsContacts1"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        
        let store = UserDefaults.standard
        let key = "ContactsRelationsList"
        if let data = store.value(forKey: key) as? Data {
            let relationsList = try? JSONDecoder().decode(RelationsContactsModel.self, from: data)
            completion((relationsList?.relationContacts)!)
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
                let relationsList = try? JSONDecoder().decode(RelationsContactsModel.self, from: data)
                if relationsList != nil,
                    let data = try? JSONEncoder().encode(relationsList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(relationsList!.relationContacts ?? [])
                    print(relationsList?.relationContacts as Any)
                }
            }
                
            else {
                let describingError = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
                print(describingError)
                print(httpBody)
                print(response)
                print("error=\(String(describing: error))")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
    
    
}
