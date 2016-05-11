//
//  MonsterImg.swift
//  myLittleMonster
//
//  Created by Tobias Gozzi on 02.05.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    private var _monsterType: String = ""
    
    var monsterType: String {
        set {
            if (newValue != "") {
                _monsterType = newValue }
        }
        get {
            return _monsterType
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startingAnimation(isDeadAnimation dead: Bool, monsterType typeOfMonster: String){
        var imageArray = [UIImage]()

        if dead == false && typeOfMonster == "rock" {
            
            self.image = UIImage(named: "idle 1.png")
            
            self.animationImages = nil
            
            for var x in 1...4 {
                let img = UIImage(named: "idle \(x).png")
                imageArray.append(img!)
            }
            
            self.animationImages = imageArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 0
            self.startAnimating()
        } else if dead == true && typeOfMonster == "rock" {
            self.image = UIImage(named: "dead5.png")
            
            self.animationImages = nil
            
            for var x in 1...4 {
                let img = UIImage(named: "dead\(x).png") //still have to add images to assets folder
                imageArray.append(img!)
            }
            
            self.animationImages = imageArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 1
            self.startAnimating()
        } else if dead == false && typeOfMonster == "snail" {
            
            self.image = UIImage(named: "blue_idle (1).png")
            
            self.animationImages = nil
            
            for var x in 1...4 {
                let img = UIImage(named: "blue_idle (\(x))")
                imageArray.append(img!)
            }
            
            self.animationImages = imageArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 0
            self.startAnimating()
        } else if dead == true && typeOfMonster == "snail" {
            self.image = UIImage(named: "blue_dead (3)")
            
            self.animationImages = nil
            
            for var x in 1...3 {
                let img = UIImage(named: "blue_dead (\(x))") //still have to add images to assets folder
                imageArray.append(img!)
            }
            
            self.animationImages = imageArray
            self.animationDuration = 0.8
            self.animationRepeatCount = 1
            self.startAnimating()
        } else {
            print("no animation playing")
        }
    }


}
