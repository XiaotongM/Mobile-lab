//
//  pageCell.swift
//  KittensSpriteKit
//
//  Created by Xiaotong Ma on 2019/5/2.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import Foundation
import UIKit

class pageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            //            print(page?.imageName)
            guard let unwrappedPage = page else { return }
            firstImageView.image = UIImage(named: unwrappedPage.imageName)
        }
    }
    
    let firstImageView: UIImageView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let image = UIImage(named: "first")
        let imageView = UIImageView(image: image)
        // let imageView = UIImageView(image: first)
        // this enables autolayout for our imageView
        imageView.frame = CGRect(x:0, y:0, width: screenSize.width, height: screenSize.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .purple
        setupLayout()
        self.backgroundColor = .red
        
    }
    
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(firstImageView)
        
        topImageContainerView.backgroundColor = UIColor(red: 181/255, green: 164/255, blue: 255/255, alpha: 1.0)
        
        firstImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        firstImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        firstImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1).isActive = true
        
        firstImageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 1).isActive = true
        
        firstImageView.backgroundColor = UIColor(red: 181/255, green: 164/255, blue: 255/255, alpha: 1.0)
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
