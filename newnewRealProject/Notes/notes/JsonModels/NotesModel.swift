//
//  NotesModel.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation

struct NoteList: Codable {
    let notes:[NotesModel]
}

struct NotesModel: Codable {
    var text:String?
    var note_id:Int?
}


class NoteListModel {
    
    func retreiveNotes(completion: @escaping ([NotesModel]) -> ()) {
        
        let params = ["name":"NoteList"]
        let myUrl = URL(string: "http://dev-ios.voodoolab.io/api/get-json")
        var request = URLRequest(url: myUrl!)
        
        
        let store = UserDefaults.standard
        let key = "noteListCache"
        if let data = store.value(forKey: key) as? Data {
            let noteList = try? JSONDecoder().decode(NoteList.self, from: data)
            completion((noteList?.notes)!)
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
                let noteList = try? JSONDecoder().decode(NoteList.self, from: data)
                if noteList != nil,
                    let data = try? JSONEncoder().encode(noteList) {
                    UserDefaults.standard.set(data, forKey: key)
                }
                else{
                    print("error=\(String(describing: error))")
                }
                DispatchQueue.main.async {
                    completion(noteList!.notes ?? [])
                }
            }
                
            else {
                let describingError = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
                print(describingError as Any)
//                print(httpBody)
//                print(response as Any)
//                print("error=\(String(describing: error))")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
}
