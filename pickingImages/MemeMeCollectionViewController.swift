//
//  MemeMeCollectionViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 26..
//  Copyright © 2017년 Udacity. All rights reserved.
//


import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
}

class MemeMeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray

        let space:CGFloat = 3.0

        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space

        flowLayout.minimumLineSpacing = space

        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("        super.viewWillAppear(animated)")
        super.viewWillAppear(animated)
        print("        super.viewWillAppear(animated) terminated")

        //self.tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView start")
        
        //let cell = tableView.dequeueReusableCell( withIdentifier: "MemeTableCell")!//, for: indexPath ) as! MemeTableCell
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        print("meme call")
        let meme = memes[indexPath.item]
        print("meme image set")
        cell.cellImage.image=meme.memedImage
        print("return cell")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
         let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.theMeme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
