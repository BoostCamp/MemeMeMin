//
//  MemeMeTableViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 26..
//  Copyright © 2017년 Udacity. All rights reserved.
//


import UIKit

class MemeMeTableViewController: UITableViewController {
    
    //var appDelegate: AppDelegate!
    var memes : [Meme]!
    
   
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray
        print(memes.count)
        print("memememe")
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(memes.count)
        return memes.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "MemeTableCell")!//, for: indexPath ) as! MemeTableCell
        let theMeme = self.memes[(indexPath as NSIndexPath).row]
    
        //cell.imageView = theMeme.memedImage
        cell.detailTextLabel?.text = theMeme.bottomText
        cell.imageView?.image = theMeme.memedImage
        cell.textLabel?.text = theMeme.topText + " " + theMeme.bottomText
    
    
    
    return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //MemeDetailViewController.theMeme = memes[(indexPath as NSIndexPath).row]
       //MemeDetailViewController.theMeme = me
        //self.navigationController!.pushViewController(detailController, animated: true)
//        
        detailController.theMeme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            memes.remove(at: indexPath.row)
            appDelegate.memesArray = memes
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addButton(_ sender: Any) {
        
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
