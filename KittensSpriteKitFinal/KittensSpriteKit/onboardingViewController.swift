//
//  onboardingViewController.swift
//  KittensSpriteKit
//
//  Created by Xiaotong Ma on 2019/5/2.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit

class onboardingViewController: UIViewController {
    
    let firstImageView: UIImageView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let image = UIImage(named: "first")
        let imageView = UIImageView(image: image)
//        let imageView = UIImageView(image: first)
        // this enables autolayout for our imageView
        imageView.frame = CGRect(x:0, y:0, width: screenSize.width, height: screenSize.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // make sure you apply the correct encapsulation principles in your classes
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
//    private let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("NEXT", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        return button
//    }()
    
    private let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonTapAction(sender:UIButton!){
        //this code will navigate to next view when you press button.
        print("go to next page")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "start") as! onboardingViewController
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
