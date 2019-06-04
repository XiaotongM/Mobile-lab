//
//  swipingController.swift
//  KittensSpriteKit
//
//  Created by Xiaotong Ma on 2019/5/2.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import Foundation
import UIKit

class swipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let pages = [
        Page(imageName: "first"),
        Page(imageName: "second"),
        Page(imageName: "third")
    ]

    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.prevButton, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
//    private let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("NEXT", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
//        return button
//    }()
//
//    @objc private func handleNext() {
//        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
//        let indexPath = IndexPath(item: nextIndex, section: 0)
//        pageControl.currentPage = nextIndex
//        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
    
    private let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("START", for: .normal)
        btn.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.getStartedButton, for: .normal)
        btn.tag = 1
        return btn
    }()
    
    @objc func buttonTapAction(sender:UIButton!){
        //this code will navigate to next view when you press button.
        print("go to next page")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "start") as! ViewController

        // self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        collectionView?.backgroundColor = UIColor(red: 181/255, green: 164/255, blue: 255/255, alpha: 1.0)
        collectionView?.register(pageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
}


extension UIColor {
    static var prevButton = UIColor.init(red: 45/255, green: 35/255, blue: 124/255, alpha: 1.0) /* #2d237c */
    static var getStartedButton = UIColor.init(red: 241/255, green: 90/255, blue: 47/255, alpha: 1.0) /* #f15a2f */
}
