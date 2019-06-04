//
//  SpeechBubbleView.swift
//  KittensSpriteKit
//
//  Created by cff on 2019/4/23.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit

class SpeechBubbleView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 18)
        self.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 18)
        self.textColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }


    override func draw(_ rect: CGRect) {
//        UIColor.red.setFill()
//        let rect = CGPath(roundedRect: rect, cornerWidth: 20, cornerHeight: 20, transform: nil)
//        let bezier = UIBezierPath(cgPath: rect)
//        bezier.fill()
        
    }

}
