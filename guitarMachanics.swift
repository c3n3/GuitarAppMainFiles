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
    
    let settingsDelegate = UserDefaults.standard

    
    let Engine = audioEngineKit()

    @IBAction func BackButton(_ sender: UIButton) {
    Engine.endAll()
    
    }
    
    //Same Thing as the settings View did load
    override func viewDidLoad() {
        
        //I actually don't know what this does, I copied part of this code from the defualt game template
        super.viewDidLoad()
    
        
        //This statement is bassically the creation of the variable "view", let is the key word for a constant, the "if" is part of swift's "optional" type. an optional is an enumerated value, that means it has explicitly defined posssible values, in the optional's case, it only has two possible values. the first is "not set", and its value is nil. nil in swift means it has nothing as a value. the other value an optional can have is "set". When an optional is set then the set state also has an "associated value" the optional value is what really matters. Ok back to the "If" that is behind the "let". It is bassically saying "if you can let this new variable called view = to self(spriteViewController).view, which is the view of the view controller, as an SKView. an SKView is the view that contains SpriteKit objects. If there is an error along the line, the if will fail and the varible cannot be created.
        if let view = self.view as! SKView? {
            // Load the SKScene
            
            
            //an SKView has a scene below it, just like how a viewcontroller has a view, here we are just creating an SKscene that will be used below it
            if let scene = SKScene(fileNamed: "guitarMechanics.sks") {
             
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //self explainitory
            view.isMultipleTouchEnabled = true

            //not to sure on this one
            view.ignoresSiblingOrder = true

            //self explainatory
            view.showsFPS = true
            
            //this tells the node count of the view, nodes are the highest class order of things you  can put into an SKView, In our case, we used SKSpriteNodes
            view.showsNodeCount = true
            
            
            
        }
   
    
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let window = view.window!
        let gr0 = window.gestureRecognizers![0] as UIGestureRecognizer
        let gr1 = window.gestureRecognizers![1] as UIGestureRecognizer
        gr0.cancelsTouchesInView = false
        gr1.cancelsTouchesInView = false
        gr0.delaysTouchesBegan = false
        gr1.delaysTouchesBegan = false
        
        print("success")
    }
    @IBAction func changedPreset(_ sender: UISegmentedControl) {
        
        settingsDelegate.set(sender.selectedSegmentIndex, forKey: "preset")
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene
            
            
            //an SKView has a scene below it, just like how a viewcontroller has a view, here we are just creating an SKscene that will be used below it
            if let scene = SKScene(fileNamed: "guitarMechanics.sks") {
                
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //self explainitory
            view.isMultipleTouchEnabled = true
            
            //not to sure on this one
            view.ignoresSiblingOrder = true
            
            //self explainatory
            view.showsFPS = true
            
            //this tells the node count of the view, nodes are the highest class order of things you  can put into an SKView, In our case, we used SKSpriteNodes
            view.showsNodeCount = true
            
            let window = view.window!
            
            
            let gr0 = window.gestureRecognizers![0] as UIGestureRecognizer
            let gr1 = window.gestureRecognizers![1] as UIGestureRecognizer
            gr0.cancelsTouchesInView = false
            gr1.cancelsTouchesInView = false
            gr0.delaysTouchesBegan = false
            gr1.delaysTouchesBegan = false
            
        }
    
    }
    
    //Kinda self explainatory by language, maybe not syntax, but this code is also from the template
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }



}


//This is where it gets fun

//So this is the class that is linked to the SKScene This is the thing that coverns the spritekit library stuff, it is also linked to through the sks filerdrg
class guitarMechanics: SKScene {
    
    
    
    let Engine = audioEngineKit()

    var fretTouches: [[Double]] = [[0]]
    var savedPositions: [Any]? = nil

    var topBarSize: CGFloat = 50.0
    var doubleTapTime = 0.0 //set later from the settings
    
    var saveMode = false
    
    //This is the link to the settings that were edited in the settings view
    let settingsDelegate = UserDefaults.standard
    

    
    
    //this is a terrible name, but this is the basic sprite node that i used for making the grid of frets
     let box = SKSpriteNode()
    
    var fretScale: Float = 0.0
    var stringNumber = 1
    var fretCount = 2
    
    
    //same thing as the view did load just for scenes
    override func didMove(to view: SKView) {
        
        for i in stride(from: 1, through: 5, by: 1) {
            
            if i != 5 {
                let sprite = SKSpriteNode(imageNamed: "\(i)Button.png")
                sprite.anchorPoint = CGPoint(x: 1, y: 1)
                sprite.position = CGPoint(x: self.size.width / 2 - CGFloat(35 * i + 15), y: self.size.height / 2)
               // sprite.alpha = 0.5
                print("yess the sprite buttons were created")
                
                let spriteOverlay = SKSpriteNode()
                spriteOverlay.name = "button\(i)"
                spriteOverlay.anchorPoint = CGPoint(x: 1, y: 1)
                spriteOverlay.size = sprite.size
                spriteOverlay.color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                spriteOverlay.position = sprite.position
                spriteOverlay.alpha = 0
                spriteOverlay.zPosition = 2
                self.addChild(sprite)
                self.addChild(spriteOverlay)

                
            }
            else {
                print("save was created")
                let sprite = SKSpriteNode(imageNamed: "save.png")
                //sprite.alpha = 0.5
                sprite.anchorPoint = CGPoint(x: 1, y: 1)
                
                sprite.position = CGPoint(x: self.size.width / 2 - CGFloat(35 * i + 15), y: self.size.height / 2)
                self.addChild(sprite)
                
                let spriteOverlay = SKSpriteNode()
                spriteOverlay.anchorPoint = CGPoint(x: 1, y: 1)
                spriteOverlay.zPosition = 2
                spriteOverlay.name = "button\(i)"
                spriteOverlay.size = sprite.size
                spriteOverlay.color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                spriteOverlay.position = sprite.position
                spriteOverlay.alpha = 0
                
                self.addChild(spriteOverlay)
            }
            
        }
         
       savedPositions = (settingsDelegate.array(forKey: "savedPositions"))
            
      
        if savedPositions == nil {
            savedPositions = [fretTouches, fretTouches, fretTouches, fretTouches]
        }
        
        
        let preset = settingsDelegate.integer(forKey: "preset")
        
        
        
        if preset == 0{
        fretScale = settingsDelegate.float(forKey: "fretScale")
        stringNumber  = settingsDelegate.integer(forKey: "stringNumber")
        fretCount = settingsDelegate.integer(forKey: "fretCount")
        }
        else {
            fretScale = settingsDelegate.float(forKey: "fretScale2")
            stringNumber  = settingsDelegate.integer(forKey: "stringNumber2")
            fretCount = settingsDelegate.integer(forKey: "fretCount2")
            
        }
        
        
        
        
        print("didMoveToView")
        
        let topUnderlay = SKSpriteNode(color: #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1), size: CGSize(width: self.size.width, height: topBarSize))
        topUnderlay.alpha = 0.75
        topUnderlay.zPosition = 0
        topUnderlay.anchorPoint = CGPoint(x: 1, y: 1)
        topUnderlay.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(topUnderlay)
        
        //self is the height of the scene, in this case it is the phone screen height
        let y = self.size.height
        
        //same but with width
        let x = self.size.width
        
        print(x)
print(y)
        settingsDelegate.set(0.25, forKey: "doubleTapTime")
        doubleTapTime = settingsDelegate.double(forKey: "doubleTapTime")

        
        let texture = SKSpriteNode(imageNamed: "wood.jpg")
        texture.position = CGPoint(x: 0, y: 0)
        texture.zPosition = -1
        self.addChild(texture)
        
        //print(x/5, y/6)
        box.size = CGSize(width: (x / CGFloat(fretCount)), height: (y - topBarSize)/CGFloat(stringNumber))
        box.color = #colorLiteral(red: 0.5083323121, green: 0.5305921435, blue: 0.9121738076, alpha: 1)
        //print(Int(self.size.height/CGFloat(settingsDelegate.integer(forKey: "stringNumber"))))
        
        //print(settingsDelegate.integer(forKey: "stringNumber"))
        //print(self.size.height)
        
        for j in stride(from: 0, to: stringNumber , by: 1) {
            
            //fretTouches is initialized with 1 already
            if j != stringNumber - 1  {
                fretTouches.append([0]) //creates first demension
            }
            for i in stride(from: 0, to: fretCount - 1, by: 1) {
                
                    fretTouches[j].append(0)//and now the second demension is created
                
            //print(j, i, fretTouches)
                
        }}
        
     print(settingsDelegate.object(forKey: "stringTuning"))
        
        for j in stride(from: 0, to: Int(self.size.height/box.size.height + 0.5), by: 1) {
            //set up the string sprite
            let string = SKSpriteNode()
            string.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            string.alpha = 1
            string.zPosition = 2
            string.size.width = self.size.width
            string.size.height = 3
            
            //anchor point set as ther middle right
            string.anchorPoint = CGPoint(x: 1, y: 0.5)
            
            //
            string.position = CGPoint(x: x/2, y: ((y)/2) - topBarSize - (CGFloat(j) * (((y - topBarSize)/CGFloat(stringNumber)))) - 0.5 * (((y - topBarSize)/CGFloat(stringNumber))) )
            self.addChild(string)

            for i in stride(from: 0, to: fretCount, by: 1) {

                
                
                let sprite = box.copy() as! SKSpriteNode
                sprite.alpha = 0
                sprite.anchorPoint = CGPoint(x: 1, y: 1) // makes each sprite be places by top left corner
                sprite.position = CGPoint(x: (x/2) - (CGFloat(i) * (box.size.width)), y: ((y)/2) - topBarSize - (CGFloat(j) * (((y - topBarSize)/CGFloat(stringNumber))))) // position for each sprite with spacing
                if i + 1 != Int(self.size.width/box.size.width + 0.5) {
                    sprite.name = "\(j)\(i+1)"//code name of sprite is just two numbers corisponding to string and fret
                }
                else {
                    sprite.color = #colorLiteral(red: 0.09632147104, green: 0.9556006789, blue: 0.04333939403, alpha: 1)
                    sprite.name = "string\(j)"//code name of sprite is just two numbers corisponding to string and fret
                    sprite.alpha = 0.25
                }
                self.addChild(sprite)
                
               
                
                }
            
        }
   for i in stride(from: 0, to: fretCount - 1, by: 1) {
    var fret = SKSpriteNode(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), size: CGSize(width: 3, height: self.size.width - 50))
    
    if i == fretCount - 1 {
        fret.color = #colorLiteral(red: 0.05306320637, green: 0.9912917018, blue: 0.01806385629, alpha: 1)
        
    }
    
    fret.alpha = 1
    fret.anchorPoint = CGPoint(x: 0, y: 1)
    fret.zPosition = 1
    fret.position = CGPoint(x: (x/2) - (CGFloat(i + 1) * (box.size.width)), y: y/2 - 50)
    self.addChild(fret)
        }
    
    }
    
    func toggleFret(stringNumber: Int, fretNumber: Int, turnOn: Bool) {
        
        if turnOn {
            self.childNode(withName: "\(stringNumber)\(fretNumber)")?.alpha = 0.5
            fretTouches[stringNumber][fretNumber - 1] = 1
        }
        else {
            self.childNode(withName: "\(stringNumber)\(fretNumber)")?.alpha = 0
            fretTouches[stringNumber][fretNumber - 1] = 0
            
        }
        
    }
    
    //given the fret number and the string with which the bar command was issued on, this function will turn all frets below that certain fret on, inclusive to that fret too
    func barFretToggle(FretNumber lane: Int, fretHeight beginingString: Int, bar itBars: Bool) {
        
        fretTouches[beginingString][lane - 1] = 3
        if itBars {
        for j in stride(from: stringNumber - 1, to: beginingString, by: -1) {
         
            toggleFret(stringNumber: j, fretNumber: lane, turnOn: true)
            }
            
        }
            else {
                for j in stride(from: beginingString, to: stringNumber, by: 1) {
                    
                    
                    
                    toggleFret(stringNumber: j, fretNumber: lane, turnOn: false)
                    
                    
                    
                }
            
        }
    }
    
    func saveFretPosition(identifier positionIdentifier: Int) {
        
        for index in stride(from: 0, to: 4, by: 1) {
            
            if index == positionIdentifier {
                
                savedPositions?[index] = fretTouches
                
                
                settingsDelegate.set(savedPositions, forKey: "savedPositions")
                
            }
            
            
        }
       
    }
    
    //call this to display the saved content
    func displaySavedFretPossition(identifier positionIdentifier: Int) {
        for index in stride(from: 0, to: 4, by: 1) {
            
            if index == positionIdentifier {
                fretTouches = savedPositions?[index] as! [[Double]]
                var first = true
                for string in stride(from: 0, to: stringNumber, by: 1) {
                    for fret in stride(from: 0, to: fretCount, by: 1) {
                        
                        if self.childNode(withName: "\(string)\(fret)") != nil {
                        
                        self.childNode(withName: "\(string)\(fret + 1)")?.alpha = 0
                            print("it got to this point within displaySaved...", fretTouches, savedPositions?[index])
                        if fretTouches[string][fret] != 0 && fretTouches[string][fret] < 5 {
                            if first {
                                //four means that fret is the "commander of the saved position" it will act as if the all the frets are controlled by it
                                fretTouches[string][fret] = 4
                            self.childNode(withName: "\(string)\(fret + 1)")?.alpha = 1
                                first = false
                            }
                            else {
                                self.childNode(withName: "\(string)\(fret + 1)")?.alpha = 0.5

                            }
                            }
                        }
                        
                        
                    }
                }
            }
        }
    
    print("finished")
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        // sift through all the touches
         for touch in touches{
            //print(touch.location(in: self))

            let timeInterval = touch.timestamp
            
            //selfexplainatory
            let location = touch.location(in: self)
            
            

            
            //starts iterating through all the sprites, this first loop is for string
           outerLoop: for string in stride(from: 0, to: stringNumber, by: 1){
            
            if self.childNode(withName: "string\(string)")?.contains(location) ?? false {
                
                //print(-(touch.location(in: self.childNode(withName: "string\(string)")!).x) / box.size.width)

                for (index, fret) in fretTouches[string].enumerated().reversed() {
                    if fret <= 5 && fret != 0 {
                        Engine.playSound(fretNumber: index + 1, volume: Float(-(touch.location(in: self.childNode(withName: "string\(string)")!).x) / box.size.width), string : string)
                        break
                        
                    }
                    else if index == 0 && (fret == 0 || fret > 5){
                        Engine.playSound(fretNumber: 0, volume: Float(-(touch.location(in: self.childNode(withName: "string\(string)")!).x) / box.size.width), string : string)
                        break
                    }
                }
            }
            
            //this loop is for frets
                for fret in stride(from: 1, to: fretCount + 1, by: 1) {
                    if self.childNode(withName: "\(string)\(fret)")?.contains(location) ?? false{
                        
                        // i minus one because sprites are named starting at one
                        

                        
                        if timeInterval - fretTouches[string][fret - 1] <= doubleTapTime && fretTouches[string][fret - 1] != 1 && fretTouches[string][fret - 1] != 0 {
                            
                            barFretToggle(FretNumber: fret, fretHeight: string, bar: true)
                            //fretTouches[string][fret - 1] = 3
                        }
                       else if fretTouches[string][fret - 1] == 0 || fretTouches[string][fret - 1] > 5 {
                            
                            
                            fretTouches[string][fret - 1] = 2
                        }
                        
                        self.childNode(withName: "\(string)\(fret)")?.alpha = 0.5

                       
                       // break outerLoop
                        
                        
                    }

                }
            
            
            
            
        }
            
            for i in stride(from: 1, through: 5, by: 1) {
                if self.childNode(withName: "button\(i)")?.contains(location) ?? false {
                    if i != 5 {
                        if saveMode == false {
                        displaySavedFretPossition(identifier: i - 1)
                        print(i)
                        }
                        else {
                            print("saved")
                        saveFretPosition(identifier: i - 1)
                        
                        saveMode = false
                        }
                    }
                    else {
                        saveMode = true
                    }
                }
            }
            
    }
    }
   
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
         for touch in touches{
            
            
            let location = touch.location(in: self)
            
           outerLoop: for string in stride(from: 0, to: stringNumber, by: 1){
            
            if self.childNode(withName: "string\(string)")?.contains(location) ?? false && self.childNode(withName: "string\(string)")?.contains(touch.previousLocation(in: self)) ?? false == false {
                
                for (index, fret) in fretTouches[string].enumerated().reversed() {
                    if fret <= 5 && fret != 0 {
                        Engine.playSound(fretNumber: index + 1, volume: Float(-(touch.location(in: self.childNode(withName: "string\(string)")!).x) / box.size.width), string : string)
                        break
                    }
                    else if index == 0 && (fret == 0 || fret > 5) {
                        Engine.playSound(fretNumber: 0, volume: Float(-(touch.location(in: self.childNode(withName: "string\(string)")!).x) / box.size.width), string : string)
                        break
                    }
                }
                
            }
                
                for fret in stride(from: 1, to: fretCount + 1, by: 1) {
                   
                    if self.childNode(withName: "\(string)\(fret)")?.contains(location) ?? false{
                        

                        
                        
                        if (self.childNode(withName: "\(string)\(fret)")?.contains(touch.previousLocation(in: self))) == false {
                        
                            
                            
                            
                            toggleFret(stringNumber: string, fretNumber: fret, turnOn: true)
                            
                           // Engine.fretSlide(fretNumber: i, string: j)
                            
                            
                            //this finds the previous fret that the touch was on in order to do operations
                            for string2 in stride(from: 0, to: stringNumber, by: 1){
                                
                                for fret2 in stride(from: 1, to: fretCount + 1, by: 1) {
                            
                                    if self.childNode(withName: "\(string2)\(fret2)")?.contains(touch.previousLocation(in: self)) ?? false {
                                        
                                        
                                        if fretTouches[string2][fret2 - 1] == 3 {
                                            toggleFret(stringNumber: string2, fretNumber: fret2, turnOn: false)

                                           barFretToggle(FretNumber: fret2, fretHeight: string2, bar: false)
                                        barFretToggle(FretNumber: fret, fretHeight: string, bar: true)
                                            
                                            
                                        }
                                        else {
                                            toggleFret(stringNumber: string2, fretNumber: fret2, turnOn: false)

                                        }

                                        
                                        
                                        break outerLoop
                                    
                                        
                                    }
                                    
                                }
                                
                            }
                    }
                        else {
                            break outerLoop
                        }
                        
                    }
                    

                }
                

            }
            
            
        }
        }
    
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        //print(touches)
        
        outerLoop: for touch in touches{
            

            let location = touch.location(in: self)
            
            for string in stride(from: 0, to: stringNumber, by: 1){
                if self.childNode(withName: "string\(string)")?.contains(location) ?? false {
                    
                    
                    
                }
                for fret in stride(from: 1, to: fretCount + 1, by: 1) {
                    if self.childNode(withName: "\(string)\(fret)")?.contains(location) ?? false{
                        self.childNode(withName: "\(string)\(fret)")?.alpha = 0

                        if fretTouches[string][fret - 1] == 3 {
                            barFretToggle(FretNumber: fret, fretHeight: string, bar: false)
                            
                        }
                        else if fretTouches[string][fret - 1] == 2 {
                            
                            fretTouches[string][fret - 1] = touch.timestamp
                        }
                        else {
                        fretTouches[string][fret - 1] = 0
                        }
                        
                        
                        if (self.childNode(withName: "\(string)\(fret)")?.contains(touch.previousLocation(in: self))) == false {
                            
                            for string2 in stride(from: 0, to: stringNumber, by: 1){
                                
                                for fret2 in stride(from: 1, to: fretCount + 1, by: 1) {
                                    
                                    if self.childNode(withName: "\(string2)\(fret2)")?.contains(touch.previousLocation(in: self)) ?? false {
                                        if fretTouches[string2][fret2 - 1] == 3 {
                                            barFretToggle(FretNumber: fret2, fretHeight: string2, bar: false)
                                            
                                        }
                                        toggleFret(stringNumber: string2, fretNumber: fret2, turnOn: false)
                                       // break outerLoop
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                        else {
                            //break outerLoop
                        }
                    }
                    
                    
                }
                
            }
            
            
        }
    
    }

    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ha screw you I just cancelled a touch")
        
        
        print(touches.count)
    }
    
    
    }

