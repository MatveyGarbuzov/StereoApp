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
  case empty = "Empty"
}

struct Instrument {
  //  var id: Int
  var name: InstrumentName?
  var image: UIImage?
  
  init(name: InstrumentName? = nil, image: UIImage? = nil) {
    self.name = name
    self.image = image //UIImage(named: "\(String(describing: name?.rawValue))")
    print("ASF")
  }
}

final class Orchestra {
  var instruments: [Instrument] = [
    Instrument(),
    Instrument(),
    Instrument(),
    Instrument()
  ]
}

final class AllInstruments {
  var list: [Instrument] = [
    Instrument(name: .piano, image: UIImage(named: "Piano")),
    Instrument(name: .guitar, image: UIImage(named: "Guitar"))
  ]
}
