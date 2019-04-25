//
//  SignUpVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 29/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    
    //MARK: Outlets:
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func confirm(_ sender: UIButton) {
        guard let username = userNameTextField.text,
              username != "",
              let email = emailTextField.text,
              email != "",
              let password = passwordTextField.text,
              password != ""
            else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all fields")
                return
        }
        
        //MARK: Creating user:
        Auth.auth().createUser(withEmail: email, password: password,completion:  { (user, error) in
            
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let userrr = user else {return}
            print(userrr.user.email ?? "MISSING EMAIL")
            print(userrr.user.uid)
            
            let changeRequest = userrr.user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
            })
            
        })
        
    }
    

}
