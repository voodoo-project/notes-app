//
//  ProfileContactsRealtionsModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 04/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

struct Relations:Codable {
    var profile_contacts_relation:[ProfileContactsRelations]
}
struct ProfileContactsRelations:Codable{
    var name:String?
    var image:URL?
}

class ProfileRelations{
    
    func retreiveMyRelations(completion: @escaping ([ProfileContactsRelations]) -> ()) {
        
        let params = ["name":"ProfileRelations"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        let store = UserDefaults.standard
        let key = "MyProfileContactsRelationsCache"
        if let data = store.value(forKey: key) as? Data {
            let contactsRelationsList = try? JSONDecoder().decode(Relations.self, from: data)
            completion((contactsRelationsList?.profile_contacts_relation)!)
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
                let contactsRelationList = try? JSONDecoder().decode(Relations.self, from: data)
                if contactsRelationList != nil,
                    let data = try? JSONEncoder().encode(contactsRelationList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(contactsRelationList!.profile_contacts_relation ?? [])
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

