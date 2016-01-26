//
//  ViewController.swift
//  MemeMe
//
//  Created by Egorio on 1/20/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var pickImageFromCameraButton: UIBarButtonItem!
    @IBOutlet weak var pickImageFromAlbumButton: UIBarButtonItem!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var textTop: UITextField!

    let notificationCenter = NSNotificationCenter.defaultCenter()
    let textTopDelegate = MemeTextFieldDelegate()
    let textBottomDelegate = MemeTextFieldDelegate()
    let memeTextAttributes = [
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSStrokeWidthAttributeName: 3.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        initTextFields()
        initToolbars()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        subscribeKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        unsubscribeKeyboradNotification()
    }

    func initToolbars() {
        pickImageFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        pickImageFromAlbumButton.enabled = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    }

    func initTextFields() {
        textTop.text = "TOP"
        textTop.delegate = textTopDelegate
        textTop.defaultTextAttributes = memeTextAttributes
        textTop.textAlignment = NSTextAlignment.Center

        textBottom.text = "BOTTOM"
        textBottom.delegate = textBottomDelegate
        textBottom.defaultTextAttributes = memeTextAttributes
        textBottom.textAlignment = NSTextAlignment.Center
    }

    func initPickAnImageButton(sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        presentViewController(controller, animated: true, completion: nil)
    }

    func subscribeKeyboardNotifications() {
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func unsubscribeKeyboradNotification() {
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        if textBottom.isFirstResponder() {
            view.frame.origin.y = -(notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePreview.image = image
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        initPickAnImageButton(.PhotoLibrary)
    }

    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        initPickAnImageButton(.Camera)
    }
}
