//
//  ViewController.swift
//  pickingImages
//
//  Created by 오형민 on 2017. 1. 24..
//  Copyright © 2017년 Udacity. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var activeTextField: UITextField!

    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    var memeImage: Meme!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check whether the application could use camera
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if imageView != nil, (imageView.image != nil) {
            self.shareButton.isEnabled = true
            self.cancelButton.isEnabled = true
            
        }else{
            self.shareButton.isEnabled = false
            // TODO: delete this code when CreateMemeViewController is used at the main view controller
            self.cancelButton.isEnabled = false}
        
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = .center
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.textAlignment = .center
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    //#keyboard
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }

    func save(memedImage: UIImage) {
        // Create the meme

        memeImage = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: memedImage)
        //..Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate

       // AppDelegate.meme.append(memeImage)
        appDelegate.memesArray.append(memeImage)
        //( UIApplication.shared.delegate as! AppDelegate ).memesArray.append( self.memeImage )

        //let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        self.navigationController!.isNavigationBarHidden=true
        UIGraphicsBeginImageContext(self.view.frame.size)
        
       view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.navigationController!.isNavigationBarHidden=false

        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let textMessage = UIActivityType.message
        //message로 공유하기 시도 벗 잇 이즌 웤
        let shareController = UIActivityViewController(activityItems: [memedImage, textMessage], applicationActivities: nil)
        
        // = [UIActivityType.message]
        shareController.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> Void in
            if (completed) {
                self.save(memedImage: memedImage)
            }
        }
        
        present(shareController, animated: true, completion: nil)
        
      
      //  let _ = navigationController?.popToRootViewController(animated: true)


        
    }
    
    @IBAction func cancel(_ sender: Any) {
        imageView.image = nil
        topTextField.text="TOP"
        bottomTextField.text="Bottom"
        cancelButton.isEnabled=false
        shareButton.isEnabled=false
        if memeImage != nil{
            memeImage = nil
        }
        
    }
    

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
  
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //self.imageView.image = selectedImage
            //크기 맞춰줄 필요 없어서 제외
            //imageView.contentMode = .scaleAspectFit
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
            self.shareButton.isEnabled = true

        }
        
    }
    
    
    // MARK: Delegate methods of UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO: clear when textField.text == "TOP" or "BOTTOM"
        if textField.text! == "TOP" || textField.text! == "BOTTOM" {
            textField.text = ""
        }
        
        self.activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeTextField = nil
        //unsubscribeFromKeyboardNotifications()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.activeTextField = nil
        //unsubscribeFromKeyboardNotifications()
        
    }

    @IBAction func save(_ sender: Any) {
        
        
        
        
        
    }
        
   
    
}

