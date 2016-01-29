//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Egorio on 1/28/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFlowLayout()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        collectionView!.reloadData()

        setupFlowLayout()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    /*
     * Return collection cell
     */
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell

        cell.image.image = meme.imageMemed

        return cell
    }

    /*
     * Display preview controller by clicking by cell
     */
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("PreviewViewController") as! PreviewViewController

        controller.meme = memes[indexPath.row]

        navigationController!.pushViewController(controller, animated: true)
    }

    /*
     * Recaltulate cell sizes on iphone rotating
     */
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        setupFlowLayout()
    }

    /*
     * Configure cells size and spacing between them
     */
    func setupFlowLayout() {
        let items: CGFloat = view.frame.size.width > view.frame.size.height ? 5.0 : 3.0
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - ((items + 1) * space)) / items

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 8.0 - items
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
}