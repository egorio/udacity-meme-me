//
//  PreviewViewController.swift
//  MemeMe
//
//  Created by Egorio on 1/29/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imagePreview: UIImageView!

    var meme: Meme!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        imagePreview.image = meme.imageMemed
    }

    @IBAction func edit(sender: UIBarButtonItem) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController

        controller.meme = meme

        presentViewController(controller, animated: true, completion: nil)
    }
}
