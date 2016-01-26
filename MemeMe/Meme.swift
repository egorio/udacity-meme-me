//
//  Meme.swift
//  MemeMe
//
//  Created by Egorio on 1/25/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var textTop: String
    var textBottom: String
    var imageOriginal: UIImage
    var imageMemed: UIImage

    init(textTop: String, textBottom: String, imageOriginal: UIImage, imageMemed: UIImage) {
        self.textTop = textTop
        self.textBottom = textBottom
        self.imageOriginal = imageOriginal
        self.imageMemed = imageMemed
    }
}