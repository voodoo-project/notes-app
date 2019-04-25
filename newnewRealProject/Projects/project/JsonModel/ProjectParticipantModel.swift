//
//  ProjectParticipantModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation


struct ProjectParticipantsModel:Codable {
    var projectParticipant:[Participant]
}
struct Participant:Codable{
    var name:String?
    var someInfo:String?
    var imageURL:URL?
}

class ProjectParticipant{
    
    func retreiveMyParticipants(completion: @escaping ([Participant]) -> ()) {
        
        let params = ["name":"ProjectParticipants"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        let store = UserDefaults.standard
        let key = "MyProjectParticipantsCache"
        if let data = store.value(forKey: key) as? Data {
            let projectParticipantsList = try? JSONDecoder().decode(ProjectParticipantsModel.self, from: data)
            completion((projectParticipantsList?.projectParticipant)!)
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
                let projectParticipantList = try? JSONDecoder().decode(ProjectParticipantsModel.self, from: data)
                if projectParticipantList != nil,
                    let data = try? JSONEncoder().encode(projectParticipantList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(projectParticipantList!.projectParticipant ?? [])
                    print(projectParticipantList?.projectParticipant)
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

