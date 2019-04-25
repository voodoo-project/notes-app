//
//  NoteVCExtension.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 19/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit

extension NoteVC : UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneButton.isHidden {
            textView.text.removeAll()
            textView.textColor = .white
            
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
