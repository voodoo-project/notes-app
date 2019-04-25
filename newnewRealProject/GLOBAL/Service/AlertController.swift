//
//  AlertController.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 29/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class AlertController {

    static func showAlert(_ inViewController: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
    
}
