//
//  ProjectVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 22/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {

    //MARK: Properties:
    var subViews:[UIViewController] = []
    //MARK: Outlets:
    @IBOutlet weak var changingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews(subviews: [ProjectInfo(),ProjectNotesVC(),ProjectParticipants(),ProjectSettings()])
        
    }
    
    
    //MARK: segmentedCtrl Code:
    @IBAction func mySegmentedAction(_ sender: UISegmentedControl) {
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
}
