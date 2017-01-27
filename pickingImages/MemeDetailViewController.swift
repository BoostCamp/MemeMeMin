//
//  MemeDetailViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 27..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import Foundation
import UIKit


class MemeDetailViewController: UIViewController
{
    @IBOutlet weak var imgView: UIImageView!
    
    var theMeme: Meme!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.imgView!.image = theMeme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
