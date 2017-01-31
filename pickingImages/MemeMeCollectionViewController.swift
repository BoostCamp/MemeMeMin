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
        self.collectionView?.reloadData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray

        let space:CGFloat = 3.0

        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space

        flowLayout.minimumLineSpacing = space

        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memesArray
        self.collectionView?.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.cellImage.image=meme.memedImage        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
         let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.theMeme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
