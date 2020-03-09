//
//  GenderSelection.swift
//  Sehat Kahani
//
//  Created by M Zia Ur Rehman Ch. on 11/10/2017.
//  Copyright © 2017 M Zia Ur Rehman Ch. All rights reserved.
//

import UIKit

class GenderSelection: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleimageView: UIImageView!
    @IBOutlet weak var maleimageView: UIImageView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shadowView: UIViewX!
    @IBOutlet weak var viewsampel: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var centerlabel: UILabel!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = userImageView.center
        
       

        userImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2.3, height: self.view.frame.width / 2.3)
        userImageView.center = center
        cameraButton.center.y = userImageView.center.y + (userImageView.frame.height / 2)
        let buttoncenter = cameraButton.center
        cameraButton.frame = CGRect(x: 0, y: 0, width: userImageView.frame.width / 5, height: userImageView.frame.width / 5)
        cameraButton.center = buttoncenter
        
        userName.frame.origin.y = self.cameraButton.frame.origin.y + cameraButton.frame.height
        
//        femaleButton.frame = CGRect(x: 0, y: 0 , width: 400, height: 500)
        userImageView.cornerRadius()
        cameraButton.cornerRad()
        genderView.layer.cornerRadius = self.genderView.layer.frame.height / 10
        shadowView.layer.cornerRadius = self.shadowView.layer.frame.height / 10
        continueButton.cornerRad()
        
         maleimageView.tintColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
 

    }
    @IBAction func profilePhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        profileImage.image = image
//        dismiss(animated:true, completion: nilź
//    }
//
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                profileImage.image = image
                profileImage.contentMode = .scaleToFill
        }
                dismiss(animated:true, completion: nil)
        
    }
    @IBAction func femaleButton(_ sender: Any) {
        print(123)
        maleimageView.tintColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        femaleimageView.tintColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        femaleLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        maleLabel.textColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        
    }
    
    @IBAction func maleButton(_ sender: Any) {
        print(345)
        femaleimageView.tintColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
        maleimageView.tintColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        maleLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.1254901961, blue: 0.3294117647, alpha: 1)
        femaleLabel.textColor = #colorLiteral(red: 0.646869719, green: 0.6509646773, blue: 0.6550283432, alpha: 1)
    }
    @IBAction func continueAction(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}










