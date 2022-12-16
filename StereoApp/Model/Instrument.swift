//
//  Instrument.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 15.12.2022.
//

import Foundation
import UIKit

enum InstrumentName: String, CaseIterable {
  case guitar = "Guitar"
  case piano = "Piano"
  case trombone = "Trombone"
  case violin = "Violin"
  case bells = "Bells"
  case empty = "Clear"
}

struct Instrument {
  var name: InstrumentName?
  var image: UIImage?
  var side: Float = 0.0 // -1.0...1.0
  var volume: Float = 0.5 // 0.0...1.0
  
  init(name: InstrumentName? = nil, image: UIImage? = nil) {
    self.name = name
    self.image = image //UIImage(named: "\(String(describing: name?.rawValue))")
  }
}

final class Orchestra {
  var instruments: [Instrument] = [
    Instrument(name: .empty, image: UIImage(systemName: "clear")),
    Instrument(name: .empty, image: UIImage(systemName: "clear")),
    Instrument(name: .empty, image: UIImage(systemName: "clear")),
    Instrument(name: .empty, image: UIImage(systemName: "clear"))
  ]
}

final class AllInstruments {
  var list: [Instrument] = [
    Instrument(name: .empty, image: UIImage(systemName: "clear")),
    Instrument(name: .piano, image: UIImage(named: "Piano")),
    Instrument(name: .guitar, image: UIImage(named: "Guitar")),
    Instrument(name: .trombone, image: UIImage(named: "Trombone")),
    Instrument(name: .violin, image: UIImage(named: "Violin")),
    Instrument(name: .bells, image: UIImage(named: "Bells"))
  ]
}
