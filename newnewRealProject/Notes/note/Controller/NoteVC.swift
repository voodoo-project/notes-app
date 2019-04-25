//
//  NoteVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 21/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import CoreData

class NoteVC: UIViewController {

    //MARK: Properties:
    var managedContext: NSManagedObjectContext!
    var todo:Notes?
    
    
    //MARK: Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with: )),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        textView.becomeFirstResponder()
        
        if let todo = todo {
            textView.text = todo.title
            textView.text = todo.title//два раза потому что xcode багованый
            segmentedControl.selectedSegmentIndex = Int(todo.priority)
        }
    }
    
    
    //MARK: Actions
    @objc func keyboardWillShow(with notification: Notification){
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else {return}
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func done(_ sender: UIButton) {
        guard let title = textView.text, !title.isEmpty else {
            return
        }
        
        if todo == nil {
            todo = Notes()
        }
        if let todo = todo {
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
            todo.date = Date() as NSDate
            
            do {
                try managedContext.save()
                dismissAndResign()
            } catch {
                print("Saving Context error: \(error.localizedDescription)")
            }
        }
//        if let todo = self.todo {
//            todo.title = title
//            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
//        }
//        else {
//            let todo = Notes()
//            todo.title = title
//            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
//            todo.date = Date() as NSDate
//        }
        
//        do {
//            try managedContext.save()
//            dismissAndResign()
//        } catch  {
//            print("Error saving todo: \(error)")
//        }
    }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismissAndResign()
    }
    
}



