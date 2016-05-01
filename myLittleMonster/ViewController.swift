//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Tobias Gozzi on 27.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var heart: DragImg!
    @IBOutlet weak var food: DragImg!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray = [UIImage]()
        
        for var x in 1...4 {

            let img = UIImage(named: "idle \(x)")
            imageArray.append(img!)
        }
        
        monsterImg.animationImages = imageArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
        
    }


}

