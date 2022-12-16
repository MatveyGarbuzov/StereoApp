//
//  AudioPlayerController.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 16.12.2022.
//

import AVFoundation
import UIKit

final class AudioPlayerController {
  
  private var audioPlayer = AVAudioPlayer()
  private var audioQueue: AVQueuePlayer?
  
  //  private var player = [AVPlayerItem]()
  
  private let alertSound = NSDataAsset(name: "GuitarSound")
  private var alertSounds: [NSDataAsset]?
  
  
  
  private func playSound(side: Float, volume: Float, alertSound: NSDataAsset) {
    do {
      audioPlayer = try AVAudioPlayer(data: (alertSound.data), fileTypeHint: nil)
      audioPlayer.pan = side//-1.0 // left side
      //      audioPlayer.pan = -1.0 // right side
      //      audioPlayer.pan = 0.0 // center
      audioPlayer.volume = volume//1.0 // (0.0 - 1.0)
      audioPlayer.prepareToPlay()
      audioPlayer.play()
      audioPlayer.numberOfLoops = 5
      print("AUDIO PLAYING \(alertSound)")
    } catch {
      print("Error with playing music")
    }
  }
  
  private func nameToSong(orchestra: Orchestra) -> [NSDataAsset] {
    var sounds = [NSDataAsset]()
    
    for i in 0..<orchestra.instruments.count {
      if orchestra.instruments[i].name != nil {
        // transfer to NSDataAsset
        let currentInstrumentName = orchestra.instruments[i].name
        var alertSound: NSDataAsset
        switch currentInstrumentName {
        case .guitar:
          alertSound = NSDataAsset(name: "GuitarSound")!
        case .piano:
          alertSound = NSDataAsset(name: "PianoSound")!
        default:
          alertSound = NSDataAsset(name: "ErrorSound")!
        }
                playSound(side: orchestra.instruments[i].side, volume: orchestra.instruments[i].volume, alertSound: alertSound)
        
        sounds.append(alertSound)
      }
    }
    return sounds
  }
  
  private func configure(orchestra: Orchestra) -> AVQueuePlayer {
    var files = [String]()
    for i in 0..<orchestra.instruments.count {
      if let name = orchestra.instruments[i].name?.rawValue {
        files.append(name + "Sound")
      }
    }
    
    let player: AVQueuePlayer = {
      var pathArray = [String]()
      files.forEach { resource in
        if let path = Bundle.main.path(forResource: resource, ofType: "wav") {
          pathArray.append(path)
        }
      }

      var urlArray = [URL]()
      pathArray.forEach { path in
        urlArray.append(URL(fileURLWithPath: path))
      }
      
      var playerItems = [AVPlayerItem]()
      urlArray.forEach { url in
        playerItems.append(AVPlayerItem(url: url))
      }
      
      let player = AVQueuePlayer(items: playerItems)
      player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.advance
      
      return player
    }()
    return player
  }
  
  private func printInfo(orchestra: Orchestra) {
    print("")
    print("SETTINGS: ")
    for i in 0..<orchestra.instruments.count {
      print("NAME: ", orchestra.instruments[i].name)
      print("VOLUME: ",orchestra.instruments[i].volume)
      print("SIDE: ",orchestra.instruments[i].side)
      print()
    }
    print("")
  }
  
  public func play(orchestra: Orchestra) {
    print(orchestra)
    
    audioQueue = configure(orchestra: orchestra)
    print("Music playing.")
    printInfo(orchestra: orchestra)
    audioQueue?.play()
    
  }
}
