//
//  AudioSynthFile.swift
//  Guitar
//
//  Created by cad on 12/19/18.
//  Copyright © 2018 caden. All rights reserved.
//

import Foundation
import AudioKit


class audioEngine {
    
    //Sample object, Sampling is sound talk for using a audio file and applying sound effects to it, this is the object that does so
    let samplePlayer = AKAppleSampler()
    
    init() { //This function is called when an object of this class is created
        //sample player loads its file. (it is an AKAudiofile; that is just a file type for this library) the AKAudioFile then loads its representation using a url, the Bundle.main crap and then the rest is just specifying the file name.
        try! samplePlayer.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        AudioKit.output = samplePlayer //AudioKit is the overarching object, I here set its output to be my little sample player
        try! AudioKit.start() //of course you have to start the engine
        
    }
    
    
    
    func playSound(fretNumber number: Int, string stringNumber: Int){
        
        
        if stringNumber != 5 || stringNumber != 4{
       try! samplePlayer.play(noteNumber: MIDINoteNumber(number + 60 + stringNumber * 5))
        }
        else {
            try! samplePlayer.play(noteNumber: MIDINoteNumber(number + 60 + stringNumber * 5 - 1))
        }
        
    }
}
