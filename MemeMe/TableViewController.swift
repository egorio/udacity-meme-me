//
//  TableViewController.swift
//  MemeMe
//
//  Created by Egorio on 1/28/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    /*
     * Return table cell
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!

        cell.imageView?.image = meme.imageMemed
        cell.textLabel?.text = meme.textTop
        cell.detailTextLabel?.text = meme.textBottom

        return cell
    }

    /*
     * Display preview controller by clicking by cell
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("PreviewViewController") as! PreviewViewController

        controller.meme = memes[indexPath.row]

        navigationController!.pushViewController(controller, animated: true)
    }

    /*
     * Delete record by swipe left on cell
     */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
