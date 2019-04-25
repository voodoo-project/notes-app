//
//  SignInVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 29/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    
    //Outlets:
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    //MARK: Actions:
    @IBAction func SignUp(_ sender: UIButton) {
        
    }
    @IBAction func signInFast(_ sender: UIButton) {
        performSegue(withIdentifier: "SignInSegue", sender: nil)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
        email != "",
        let password = passwordTextField.text,
        password != ""
            else{
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user,error) in
            
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else {return}
            print(user.user.email ?? "MISSING EMAIL")
            print(user.user.displayName ?? "MISSING DISPLAY NAME")
            print(user.user.uid)
            
            self.performSegue(withIdentifier: "SignInSegue", sender: nil)
        })
    }

}
