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

class PhotoInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
ApplyFilterDelegate{
    
    private var savedImage: UIImage?
    private var currentFilter: FilterType?
    var filterType: FilterType{
        get{
            return currentFilter ?? .normal
        }
        set{
            currentFilter = newValue
            if let imageToFilter = savedImage{
                activityIndicator.startAnimating()
                imageView.isHidden = true
                DispatchQueue.global(qos: .userInitiated).async {
                    if let resultCIImage = PhotoInputViewController.filter(image: imageToFilter, withFilerType: newValue){
                        let resultImage = UIImage(ciImage: resultCIImage)
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = resultImage
                            self?.imageView.isHidden = false
                            self?.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var instruction: UILabel!
    @IBOutlet private weak var editButton: UIBarButtonItem!
    
    func setFilter(as filterType: FilterType) {
        self.filterType = filterType
    }
    
    @IBAction func dismissSegue(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "filter", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filter",
            let toFilterVC = segue.destination as? FilterViewController{
            toFilterVC.filterDelegate = self
        }
    }
    
    @IBAction func camera(_ sender: Any) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied{
            let alert = UIAlertController(title: "Camera Access", message: "Please allow camera access to take photo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
            present(alert, animated: true, completion: nil)
            activityIndicator.startAnimating()
            self.instruction.isHidden = true
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
                self.activityIndicator.stopAnimating()
                self.savedImage = image
                self.imageView.image = image
                self.instruction.isHidden = true
                self.editButton.isEnabled = true
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        activityIndicator.stopAnimating()
        picker.dismiss(animated: true, completion: nil)
        if imageView.image == nil {
            self.instruction.isHidden = false
        }
    }
    
    static func filter(image: UIImage?, withFilerType: FilterType) -> CIImage? {
        if let image = image {
            let ciImage = CIImage(image: image)
            if withFilerType == .normal{
                return ciImage
            }
            if let ciImageToFilter = ciImage{
                switch withFilerType{
                case .blur:
                    if let blurFilter = CIFilter(name: "CIGaussianBlur"){
                        blurFilter.setValue(ciImageToFilter, forKey: kCIInputImageKey)
                        blurFilter.setValue(8, forKey: kCIInputRadiusKey)
                        return blurFilter.outputImage
                    }
                case .monochrome:
                    if let monochromeFilter = CIFilter(name: "CIColorMonochrome"){
                        monochromeFilter.setValue(ciImageToFilter, forKey: kCIInputImageKey)
                        monochromeFilter.setValue(CIColor(red: 105, green: 105, blue: 105), forKey: kCIInputColorKey)
                        return monochromeFilter.outputImage
                    }
                case .halfTone:
                    if let halfToneFilter = CIFilter(name: "CICMYKHalftone"){
                        halfToneFilter.setValue(ciImageToFilter, forKey: kCIInputImageKey)
                        halfToneFilter.setValue(25, forKey: kCIInputWidthKey)
                        return halfToneFilter.outputImage
                    }
                case .crystallize:
                    if let crystallizeFilter = CIFilter(name: "CICrystallize"){
                        crystallizeFilter.setValue(ciImageToFilter, forKey: kCIInputImageKey)
                        crystallizeFilter.setValue(50, forKey: kCIInputRadiusKey)
                        return crystallizeFilter.outputImage
                    }
                default:
                    break
                }
            }
        }
        return nil
    }
}

protocol ApplyFilterDelegate {
    func setFilter(as filterType: FilterType)
}

enum FilterType {
    case monochrome
    case normal
    case blur
    case halfTone
    case crystallize
}
