//
//  ProjectListModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

struct ProjectList:Codable {
    var projects:[Project]
}
struct Project:Codable{
    var name:String?
    var imageURL:URL?
}

class MyProject{
    
    func retreiveMyProjects(completion: @escaping ([Project]) -> ()) {
        
        let params = ["name":"ProjectsModel"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        let store = UserDefaults.standard
        let key = "MyProjectListCache"
        if let data = store.value(forKey: key) as? Data {
            let projectsList = try? JSONDecoder().decode(ProjectList.self, from: data)
            completion((projectsList?.projects)!)
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
                let projectList = try? JSONDecoder().decode(ProjectList.self, from: data)
                if projectList != nil,
                    let data = try? JSONEncoder().encode(projectList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(projectList!.projects ?? [])
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
