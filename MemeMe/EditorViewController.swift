//
//  EditViewController.swift
//  MemeMe
//
//  Created by Egorio on 1/20/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var welcomeMessage: UITextView!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var pickImageFromCameraButton: UIBarButtonItem!
    @IBOutlet weak var pickImageFromAlbumButton: UIBarButtonItem!
    @IBOutlet weak var shareMemedImageButton: UIBarButtonItem!

    let keyboardMoveListener = KeyboardMoveListener()
    let textTopDelegate = MemeTextFieldDelegate()
    let textBottomDelegate = MemeTextFieldDelegate()

    var meme = Meme()

    override func viewDidLoad() {
        super.viewDidLoad()

        initToolbars()
        initTextField(textTop, text: meme.textTop, delegate: textTopDelegate)
        initTextField(textBottom, text: meme.textBottom, delegate: textBottomDelegate)

        // By defaule hide share button and display welcom message
        welcomeMessage.hidden = false
        shareMemedImageButton.enabled = false

        // If Meme has imageOriginal then we edit previously created Meme
        if let image = meme.imageOriginal {
            loadPreviewImage(image)
            (textTop.delegate as! MemeTextFieldDelegate).isDefaultText = false
            (textBottom.delegate as! MemeTextFieldDelegate).isDefaultText = false
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        keyboardMoveListener.subscribe(view, elements: [textBottom]) }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardMoveListener.unsubscribe()

        navigationController?.setToolbarHidden(true, animated: false)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setToolbarHidden(false, animated: true)
    }

    /*
     * Initialize toolbars button states
     */
    func initToolbars() {
        pickImageFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        pickImageFromAlbumButton.enabled = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    }

    /*
     * Initialize top and bottom text fields
     */
    func initTextField(element: UITextField, text: String, delegate: UITextFieldDelegate) {
        let attributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0,
        ]

        element.text = text
        element.delegate = delegate
        element.defaultTextAttributes = attributes
        element.textAlignment = NSTextAlignment.Center
        element.hidden = true
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
            loadPreviewImage(image)
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
     * Set image to preview box and display interface to edit text
     */
    func loadPreviewImage(image: UIImage) {
        imagePreview.image = image
        textBottom.hidden = false
        textTop.hidden = false
        welcomeMessage.hidden = true
        shareMemedImageButton.enabled = true
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
        var image = UIImage() ;

        for view in self.view.subviews {
            if view.restorationIdentifier == "meme" {
                // Create context with MemeView size
                UIGraphicsBeginImageContext(view.frame.size)

                // Move to MemeView position
                let statusBarHeight = (view.window?.convertRect(UIApplication.sharedApplication().statusBarFrame, fromView: view))!.height
                let navigationBarHeight = navigationController!.navigationBar.frame.height
                let context = UIGraphicsGetCurrentContext() ;
                CGContextTranslateCTM(context, 0, -(statusBarHeight + navigationBarHeight)) ;

                // Take "screenshot" of MemeView
                view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
                image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }

        return image
    }

    /*
     * Save Meme model to presistent storage
     */
    func saveMemedImage(image: UIImage) {
        meme.textTop = textTop.text!
        meme.textBottom = textBottom.text!
        meme.imageOriginal = imagePreview.image!
        meme.imageMemed = image

        // Save Meme to "presistent storage" in AppDelegate :))
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }

    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        initPickAnImageButton(.PhotoLibrary)
    }

    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        initPickAnImageButton(.Camera)
    }

    @IBAction func shareMemedImage(sender: UIBarButtonItem) {
        let image = generateMemedImage() ;
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if (completed) {
                self.saveMemedImage(image)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }

        presentViewController(controller, animated: true, completion: nil)
    }
}
