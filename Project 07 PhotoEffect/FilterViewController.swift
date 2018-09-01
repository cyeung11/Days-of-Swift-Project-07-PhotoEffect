//
//  FilterViewController.swift
//  Project 07 PhotoEffect
//
//  Created by Chris on 31/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController{
    
    let transitionManager = TransitionManager()
    var filterDelegate: ApplyFilterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        transitioningDelegate = transitionManager
    }
    
    @IBOutlet weak var filter1: UIButton!
    @IBOutlet weak var filter2: UIButton!
    @IBOutlet weak var filter3: UIButton!
    @IBOutlet weak var filter4: UIButton!
    
    @IBAction func selectFilter(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        if filterDelegate != nil{
            switch sender {
            case filter1:
                filterDelegate?.setFilter(as: .monochrome)
            case filter2:
                filterDelegate?.setFilter(as: .blur)
            case filter3:
                filterDelegate?.setFilter(as: .halfTone)
            case filter4:
                filterDelegate?.setFilter(as: .crystallize)
            default:
                break
            }
        }
    }
    
}
