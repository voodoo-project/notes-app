//
//  ViewController.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 16/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    
    
    //MARK: Properties:
    var subViews:[UIViewController] = []
    var profileModel = ProfileInfo()
    var cellInfo:[TableCellInfo] = []
    let profileImageURL = URL(string: "https://img.icons8.com/color/96/000000/user-male-skin-type-3.png")!
    
    
    // MARK: Outlets:
    @IBOutlet weak var changingView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(with: profileImageURL)
        configureViews(subviews: [SelfInfo(),RelationContactsInfo()])
    }
    
    
    //MARK: SegmentedActions:
    @IBAction func mySegmentAction(_ sender: UISegmentedControl) {
        changingView.bringSubviewToFront(subViews[sender.selectedSegmentIndex].view)
    }
    private func displayContentController(content: UIViewController,someView: UIView) {
        addChild(content)
        someView.addSubview(content.view)
        content.didMove(toParent: self)
    }
    private func configureViews(subviews: [UIViewController]) {
        subViews = [UIViewController]()
        var i = 0
        while i != subviews.count {
            subViews.append(subviews[i])
            i+=1
        }
        for subView in subViews {
            displayContentController(content: subView, someView: self.changingView)
        }
        changingView.bringSubviewToFront(subViews[0].view)
    }
    
    //MARK: LogOut
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextPage = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.present(nextPage, animated: true, completion: nil)
    }
    
    
    
    
    private func downloadImage(with url: URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print()
                return
            }
            DispatchQueue.main.async {
                self.testImageView.image = UIImage(data: data!)
            }
            }.resume()
    }
    
}

