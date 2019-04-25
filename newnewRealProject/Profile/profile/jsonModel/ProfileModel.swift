//
//  ProfileModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

struct ProfileTableModel:Codable {
    var tableCellInfos:[TableCellInfo]
}
struct TableCellInfo:Codable{
    var title:String?
    var info:String?
}

struct ProfileHeaderModel:Codable {
    var name:String?
    var profileImage:URL?
}


class ProfileInfo{
    
    func retreiveSelfInfos(completion: @escaping ([TableCellInfo]) -> ()) {
        
        let params = ["name":"SelfInfoCellInfo"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        
        let store = UserDefaults.standard
        let key = "MyProfileSelfInfoCache"
        if let data = store.value(forKey: key) as? Data {
            let selfInfoList = try? JSONDecoder().decode(ProfileTableModel.self, from: data)
            completion((selfInfoList?.tableCellInfos)!)
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
                let selfInfoList = try? JSONDecoder().decode(ProfileTableModel.self, from: data)
                if selfInfoList != nil,
                    let data = try? JSONEncoder().encode(selfInfoList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                DispatchQueue.main.async {
                    completion(selfInfoList!.tableCellInfos ?? [])
                    
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
