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
    
    

    override func viewDidLoad(){
        super.viewDidLoad()
        self.imgView.image = theMeme.memedImage
    }
}
