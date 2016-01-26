//
//  Keyboard.swift
//  MemeMe
//
//  Created by Egorio on 1/26/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import Foundation
import UIKit

class KeyboardMoveListener: NSObject {

    var view: UIView?
    var elements: [UIResponder] = []
    let notificationCenter = NSNotificationCenter.defaultCenter()

    /*
     * Subscribe to keyboard moving
     */
    func subscribe(view: UIView, elements: [UIResponder]) {
        self.view = view
        self.elements = elements

        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    /*
     * Unsubscribe from keyboard moving
     */
    func unsubscribe() {
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    /*
     * Move view above keyboard
     */
    func keyboardWillShow(notification: NSNotification) {
        for element in elements {
            if element.isFirstResponder() {
                view!.frame.origin.y = -(notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
                return
            }
        }
    }

    /*
     * Move view back to the bottom of the screen
     */
    func keyboardWillHide(notification: NSNotification) {
        view!.frame.origin.y = 0
    }
}