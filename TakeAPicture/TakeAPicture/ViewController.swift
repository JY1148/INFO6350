//
//  ViewController.swift
//  TakeAPicture
//
//  Created by Jinzhou Yan on 3/13/22.
//

import UIKit
/*
 1. imageview and button
 
 2. add to class : UIImagePickerControllerDelegate, UINavigationControllerDelegate
 
 3. click button interface: addAction
 
 4. privacy:
 Privacy - Photo Library Usage Description
 Privacy - Camera Usage Description
 
 5. localization:
 5.1 add a localizable.string file(add file--string file--name localizable)
 5.2 click on localizable on the right menu for the localizable file
 5.3 click on project in the left side top--click on project--info
 5.4 add the language you want
 5.5 create key value pair in Localizable
        "take_pic" = "take a picture";
 5.6 create var in localzationUtil in the Utilities group:
        var strTakePic = NSLocalizedString("take_pic", comment: "")
 5.7 viewdidload
        btnTakePic.setTitle(strTakePic, for: .normal)
 
 */

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnTakePic: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTakePic.setTitle(strTakePic, for: .normal)
    }
    @IBAction func takePictureAction(_ sender: Any) {
        let alertController = UIAlertController(title: "take a picture", message: "select image from library or take a picture", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "camera", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.camera){//相机是否可以获取
                let imagePicker = UIImagePickerController()//创建instance获取图像
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera//instance的资源来源是相机
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)//呈现相机的图像
            }
            print(" I am in camera ")
        }
        
        let libraryAction = UIAlertAction(title: "photo library", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){//手机相册是否可以获取
                let imagePicker = UIImagePickerController()//创建instance获取图像
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary//instance的资源来源是手机相册
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)//呈现手机相册的图像
            }
            print(" I am in phote library ")
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ action in
            print(" cancel ")
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {//完成获取图像后按ok的操作
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)//获取图像失败
            return
        }
        imgView.image = image//获取图像
        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
}

