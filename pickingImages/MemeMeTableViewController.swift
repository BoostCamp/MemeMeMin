//
//  MemeMeTableViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 26..
//  Copyright © 2017년 Udacity. All rights reserved.
//


import UIKit

class MemeMeTableViewController: UITableViewController {
    
    
    
    
    var appDelegate: AppDelegate!
    var memes: [Meme]!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        //appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray
        print(memes.count)
    
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        print("viewWillAppear appear&memesArrayNum")//,appDelegate.memesArray.count)
        memes = appDelegate.memesArray

        super.viewWillAppear(animated)
        
        // Noticed sometimes when exiting the Meme Edit view, even though the MEME was saved to the app delegate,
        // the collection didn't load the new image and refresh, so this is a fix for that
       //self.tableView.reloadData()
       //reloadInputViews()
        //self.reloadInputViews()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(memes.count)
        return memes.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MemeTableCell = tableView.dequeueReusableCell( withIdentifier: "MemeTableCell", for: indexPath ) as! MemeTableCell
        let theMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.imgMeme?.image = theMeme.memedImage
        cell.lblTop?.text=theMeme.topText
        cell.lblBottom?.text=theMeme.bottomText
        
        return cell
        
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
