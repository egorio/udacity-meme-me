//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Egorio on 1/25/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isDefaultText: Bool = true
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if isDefaultText {
            textField.text = ""
            isDefaultText = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
}
