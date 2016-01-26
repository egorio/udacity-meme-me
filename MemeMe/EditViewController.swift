//
//  EditViewController.swift
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
    @IBOutlet weak var shareMemedImageButton: UIBarButtonItem!

    let keyboardMoveListener = KeyboardMoveListener()
    let textTopDelegate = MemeTextFieldDelegate()
    let textBottomDelegate = MemeTextFieldDelegate()
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2.0,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        initTextFields()
        initToolbars()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        keyboardMoveListener.subscribe(view, elements: [textBottom]) }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardMoveListener.unsubscribe()
    }

    /*
     * Initialize toolbars button states
     */
    func initToolbars() {
        pickImageFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        pickImageFromAlbumButton.enabled = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
        shareMemedImageButton.enabled = false
    }

    /*
     * Initialize top and bottom text fields
     */
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

    /*
     * Initialize pick button according to specific source type
     */
    func initPickAnImageButton(sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        presentViewController(controller, animated: true, completion: nil)
    }

    /*
     * Handle image from camera or album
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePreview.image = image
        }
        shareMemedImageButton.enabled = true

        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
     * Handle situation user didn't choose image
     */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        shareMemedImageButton.enabled = (imagePreview.image != nil)

        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
     * Generate meme image from Meme View
     */
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)

        for view in self.view.subviews {
            if view.restorationIdentifier == "meme" {
                view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
            }
        }

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }

    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        initPickAnImageButton(.PhotoLibrary)
    }

    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        initPickAnImageButton(.Camera)
    }

    @IBAction func shareMemedImage(sender: UIBarButtonItem) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        presentViewController(controller, animated: true, completion: nil)
    }
}
