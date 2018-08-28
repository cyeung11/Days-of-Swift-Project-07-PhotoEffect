//
//  PhotoInputViewController.swift
//  Project 07 Tumblr
//
//  Created by Chris on 28/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos

class PhotoInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func edit(_ sender: Any) {
        //TODO: 
    }
    
    @IBAction func camera(_ sender: Any) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied{
            let alert = UIAlertController(title: "Camera Access", message: "Please allow camera access to take photo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = .camera
                picker.mediaTypes = [kUTTypeImage as String]
                present(picker, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func library(_ sender: UIBarButtonItem) {
        if PHPhotoLibrary.authorizationStatus() == .denied{
            let alert = UIAlertController(title: "Camera Access", message: "Please allow photo library access to get photo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .popover
            let ppc = picker.popoverPresentationController
            ppc?.barButtonItem = sender
            present(picker, animated: true, completion: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.imageView.image = image
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

