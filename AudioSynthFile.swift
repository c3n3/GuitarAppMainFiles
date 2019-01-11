//
//  AudioSynthFile.swift
//  Guitar
//
//  Created by cad on 12/19/18.
//  Copyright © 2018 caden. All rights reserved.
//

import Foundation
import AudioKit


class audioEngineKit {
    
    //Sample object, Sampling is sound talk for using a audio file and applying sound effects to it, this is the object that does so
    
    //first string for a guitar is the bottom one
   private let zeroStringSampler = AKAppleSampler()
    private let firstStringSampler = AKAppleSampler()
    private let secondStringSampler = AKAppleSampler()
    private let thirdStringSampler = AKAppleSampler()
    private let fourthStringSampler = AKAppleSampler()
    private let fifthStringSampler = AKAppleSampler()
    private let sixthStringSampler = AKAppleSampler()
    private let seventhStringSampler = AKAppleSampler()

   private let settings = UserDefaults.standard
    private let baseNote = 14 //14 for string 3
   
    private var gain = 0
    private var distortion = 0
    private var time = 0.0
    private var feedBack = 0.0
    private var stringTuning = [Any]()
    private var fretCount = 2
    private var stringCount = 1
    init() {
        let preset = settings.integer(forKey: "preset")
        
        //This function is called when an object of this class is created
        //sample player loads its file. (it is an AKAudiofile; that is just a file type for this library) the AKAudioFile then loads its representation using a url, the Bundle.main crap and then the rest is just specifying the file name.
        try! zeroStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! firstStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! secondStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! thirdStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! fourthStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! fifthStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! sixthStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        try! seventhStringSampler.loadAudioFile(AKAudioFile(forReading: Bundle.main.url(forResource: "string3", withExtension: "wav")!))
        
        if preset == 0 {
         gain = settings.integer(forKey: "gain")
         distortion = settings.integer(forKey: "distortion")
         time = settings.double(forKey: "delayTime")
         feedBack = settings.double(forKey: "delayFeedback")
            stringTuning = settings.array(forKey: "stringTuning")!
            fretCount = settings.integer(forKey: "fretCount")
            stringCount = settings.integer(forKey: "stringNumber")
        }
        else {
            gain = settings.integer(forKey: "gain2")
            distortion = settings.integer(forKey: "distortion2")
            time = settings.double(forKey: "delayTime2")
            feedBack = settings.double(forKey: "delayFeedback2")
            stringTuning = settings.array(forKey: "stringTuning2")!
            fretCount = settings.integer(forKey: "fretCount2")
            stringCount = settings.integer(forKey: "stringNumber2")
            
        }
        
        let mix = AKMixer(zeroStringSampler, firstStringSampler, secondStringSampler, thirdStringSampler, fourthStringSampler, fifthStringSampler, sixthStringSampler, seventhStringSampler)
        
        let effect = AKDelay(mix, time: time, feedback: feedBack, lowPassCutoff: 15000, dryWetMix: 0.5)
        
        
        let guitar = AKRhinoGuitarProcessor(effect, preGain: Double(gain), postGain: Double(gain), lowGain: Double(gain), midGain: Double(gain), highGain: Double(gain), distType: 1, distortion: Double(distortion))
        
        
        AudioKit.output = guitar //AudioKit is the overarching object, I here set its output to be my little sample player
        try! AudioKit.start() //of course you have to start the engine
        //note for base string = array[stringNumber*2 + settings.integer(forKey: "stringNumber") * 2]
        //note for base string octave = array[stringNumber*2+1 + settings.integer(forKey: "stringNumber") * 2]
    
    
    }
    
    private func tuner(fretNumber fret: Int, string stringNumber: Int) {
        
        
        return
    }
    
    
    func fretSlide(fretNumber number: Int, string stringNumber: Int){
        
        let arraySettings = stringTuning
        let stringNote = Int(arraySettings[stringNumber * 2 + (8 - stringCount) * 2] as! Int)
        let octaveNumber = Int(arraySettings[stringNumber * 2 + 1 + (8 - stringCount) * 2] as! Int)
        
        for i in stride(from: -1, to: settings.integer(forKey: "fretCount"), by: 1) {
            
            try! zeroStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            
        }
        
        try! zeroStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
        
        
        
    }
    
    func stopSound(string stringNumber: Int) {
        let arraySettings = stringTuning
        let stringNote = Int(arraySettings[stringNumber * 2 + (6 - stringCount) * 2] as! Int)
        let octaveNumber = Int(arraySettings[stringNumber * 2 + 1 + (6 - stringCount) * 2] as! Int)

        for i in stride(from: 0, to: fretCount + 1, by: 1) {
            
            
            if stringNumber == 0{
            try! zeroStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 1{
                try! firstStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 2{
                try! secondStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 3{
                try! thirdStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 4{
                try! fourthStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 5{
                try! fifthStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 6{
                try! sixthStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            else if stringNumber == 7{
                try! seventhStringSampler.stop(noteNumber: MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), channel: MIDIChannel(stringNumber))
            }
            //print(MIDINoteNumber(i + baseNote + stringNote + octaveNumber * 12), MIDIChannel(stringNumber))
            //print(stringNumber)
        }
        
    }
    
    func playSound(fretNumber number: Int, volume modifier: Float, string stringNumber: Int){
        let arraySettings = stringTuning
        let stringNote = Int(arraySettings[stringNumber * 2 + (6 - stringCount) * 2] as! Int)
        let octaveNumber = Int(arraySettings[stringNumber * 2 + 1 + (6 - stringCount) * 2] as! Int)
        
        let volume = 180 * (modifier * modifier)
        
        print(volume)
        //print(1 / modifier)
            stopSound(string: stringNumber)
        if stringNumber == 0 {
            try! zeroStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 1 {
        try! firstStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 2 {
            try! secondStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 3 {
            try! thirdStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 4 {
            try! fourthStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 5 {
            try! fifthStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 6 {
            try! sixthStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        else if stringNumber == 7 {
            try! seventhStringSampler.play(noteNumber:  MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12), velocity: MIDIVelocity(volume), channel: MIDIChannel(stringNumber))
        }
        //print( "Note: ", MIDINoteNumber(number + baseNote + stringNote + octaveNumber * 12))


        
    }
    func endAll(){
        //print(settings.double(forKey: "delayTime"))
       try! AudioKit.stop()
    }
    
}
