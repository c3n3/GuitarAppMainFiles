//
//  guitarMachanics.swift
//  Guitar
//
//  Created by cad on 12/17/18.
//  Copyright © 2018 caden. All rights reserved.
//

import Foundation
import SpriteKit

//Hang on Ill comment all over this soon

class spriteViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene
            if let scene = SKScene(fileNamed: "guitarMechanics.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            view.isMultipleTouchEnabled = true

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
   
    
    
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }



}



class guitarMechanics: SKScene {
    
    let settingsDelegate = UserDefaults.standard
    var noteToBePlayedInStrumEvent: [Int: Int] = [:]
    
     let box = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        let y = self.size.height
        let x = self.size.width
        let percent: CGFloat = CGFloat(settingsDelegate.float(forKey: "fretScale"))
        print(x/5, y/6)
        box.size = CGSize(width: (x/5) * percent, height: y/CGFloat(settingsDelegate.integer(forKey: "stringNumber")))
        box.color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        print(Int(self.size.height/CGFloat(settingsDelegate.integer(forKey: "stringNumber"))))
        
        print(settingsDelegate.integer(forKey: "stringNumber"))
        print(self.size.height)
        
        for j in stride(from: 0, to: Int(self.size.height/box.size.height + 0.5), by: 1){
            
            let string = SKSpriteNode()
            string.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            string.zPosition = 2
            string.size.width = self.size.width
            string.size.height = 3
            string.anchorPoint = CGPoint(x: 1, y: 0.5)
            string.position = CGPoint(x: x/2, y: (y/2) - (CGFloat(j) * ((y/CGFloat(settingsDelegate.integer(forKey: "stringNumber"))))) - 0.5 * ((y/CGFloat(settingsDelegate.integer(forKey: "stringNumber")))) )
            self.addChild(string)
        for i in stride(from: 0, to: Int(self.size.width/box.size.width + 0.5), by: 1) {

            noteToBePlayedInStrumEvent[j] = 0
            let sprite = box.copy() as! SKSpriteNode
            sprite.alpha = 0
            sprite.anchorPoint = CGPoint(x: 1, y: 1) // makes each sprite be places by top left corner
            sprite.position = CGPoint(x: (x/2) - (CGFloat(i) * (box.size.width + 2)), y: (y/2) - (CGFloat(j) * ((y/CGFloat(settingsDelegate.integer(forKey: "stringNumber")))) )) // position for each sprite with spacing
            if i + 1 != Int(self.size.width/box.size.width + 0.5) {
                sprite.name = "\(j)\(i)"//code name of sprite is just two numbers corisponding to string and fret
            }
            else {
                sprite.name = "string\(j)"//code name of sprite is just two numbers corisponding to string and fret

            }
            self.addChild(sprite)
            
           
            
            }
            
        }
   for i in stride(from: 0, to: Int(self.size.width/box.size.width + 0.5) - 1, by: 1) {
    let fret = SKSpriteNode(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: CGSize(width: 3, height: self.size.width))
    
    fret.anchorPoint = CGPoint(x: 0, y: 1)
    fret.zPosition = 1
    fret.position = CGPoint(x: (x/2) - (CGFloat(i + 1) * (box.size.width + 2)), y: y/2)
    self.addChild(fret)
        }
    
    }
    

    
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
            
            let location = touch.location(in: self)
        
            
            
           
        
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches{
            
            let location = touch.location(in: self)
            
            for j in stride(from: 0, to: Int(self.size.height/box.size.height + 0.5), by: 1){
                if self.childNode(withName: "string\(j)")?.contains(location) ?? false {
                    print("string\(j)")
                }
                for i in stride(from: 0, to: Int(self.size.width/box.size.width + 0.5), by: 1) {
            if self.childNode(withName: "\(j)\(i)")?.contains(location) ?? false{
                
                print("\(j)\(i)")
               
                noteToBePlayedInStrumEvent[j] = i
                
            }
                    
                }
                
            }
            
            
        }
    }

    }

