//
//  MemeMeTableViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 26..
//  Copyright © 2017년 Udacity. All rights reserved.
//


import UIKit

class MemeMeTableViewController: UITableViewController {
    var memes : [Meme]!
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memes.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "MemeTableCell")!//, for: indexPath ) as! MemeTableCell
        let theMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.detailTextLabel?.text = theMeme.bottomText
        cell.imageView?.image = theMeme.memedImage
        cell.textLabel?.text = theMeme.topText + " " + theMeme.bottomText
    return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.theMeme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {//UITableViewCellEditingStyle을 이용한 슬라이드시 삭제 버튼 추가
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            memes.remove(at: indexPath.row)
            appDelegate.memesArray = memes
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addButton(_ sender: Any) {
        
    }
    
}
