//
//  catScene.swift
//  KittensSpriteKit
//
//  Created by Xiaotong Ma on 2019/4/17.
//  Copyright © 2019 Xiaotong Ma. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class catScene: SKScene {
   
    let cat = SKSpriteNode(texture: nil)
    
    override func didMove(to view: SKView){
        self.backgroundColor = SKColor(red: 181/255, green: 164/255, blue: 255/255, alpha: 1.0)
    }
    
    override func update(_ currentTime: CFTimeInterval){
        /* Called before each frame is rendered */
    }
    
    var catFrames:[SKTexture]?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        self.addChild(cat)
        self.normalCat()
    }
    
    
    func normalCat(){
        var frames:[SKTexture] = []
        let catAtlas = SKTextureAtlas(named: "cat")
        
        //append texture to array
        for index in 0..<49 {
            print(index)
        }
        
        for index in 0...49 {
            print(index)
        }
        
        for index in 10...49{
            let textureName = "kitten\(index)"
            let texture = catAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.catFrames = frames
        //unwrap
        // let texture = self.catFrames![0]
        // let cat = SKSpriteNode(texture: texture)
        
        cat.size = CGSize(width: 340, height: 340)
        let screenSize: CGRect = UIScreen.main.bounds
        cat.position = CGPoint(x: screenSize.width / 2.5, y: screenSize.height / 4.5)
        
        // self.addChild(cat)
        
        cat.run(SKAction.repeatForever(SKAction.animate(with: self.catFrames!, timePerFrame: 0.05, resize: false, restore: true)))

    }
    
    
    
    func helloKitten(){
        var frames:[SKTexture] = []
        let catAtlas = SKTextureAtlas(named: "cat")
        for index in 50...99{
            let textureName = "kitten\(index)"
            let texture = catAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.catFrames = frames
        //unwrap
        let texture = self.catFrames![0]
        //let cat = SKSpriteNode(texture: texture)
        
        cat.size = CGSize(width: 340, height: 340)
        let screenSize: CGRect = UIScreen.main.bounds
        cat.position = CGPoint(x: screenSize.width / 2.5, y: screenSize.height / 4.5)
        
        //self.addChild(cat)
        cat.run(SKAction.repeatForever(SKAction.animate(with: self.catFrames!, timePerFrame: 0.05, resize: false, restore: true)))
    }
    
    
    
    func answerQuestionKitten(){
        var frames:[SKTexture] = []
        let catAtlas = SKTextureAtlas(named: "cat")
        for index in 100...149{
            let textureName = "kitten\(index)"
            let texture = catAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.catFrames = frames
        //unwrap
        let texture = self.catFrames![0]
        //let cat = SKSpriteNode(texture: texture)
        
        cat.size = CGSize(width: 340, height: 340)
        let screenSize: CGRect = UIScreen.main.bounds
        cat.position = CGPoint(x: screenSize.width / 2.5, y: screenSize.height / 4.5)
        
        //self.addChild(cat)
        cat.run(SKAction.repeatForever(SKAction.animate(with: self.catFrames!, timePerFrame: 0.05, resize: false, restore: true)))
    }
    
    
    func FeedAction(){
        var frames:[SKTexture] = []
        let catAtlas = SKTextureAtlas(named: "cat")
        for index in 150...199{
            let textureName = "kitten\(index)"
            let texture = catAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.catFrames = frames
        //unwrap
        let texture = self.catFrames![0]
        //let cat = SKSpriteNode(texture: texture)
        
        cat.size = CGSize(width: 340, height: 340)
        let screenSize: CGRect = UIScreen.main.bounds
        cat.position = CGPoint(x: screenSize.width / 2.5, y: screenSize.height / 4.5)
        
        //self.addChild(cat)
        cat.run(SKAction.repeatForever(SKAction.animate(with: self.catFrames!, timePerFrame: 0.05, resize: false, restore: true)))
    }
    
}
