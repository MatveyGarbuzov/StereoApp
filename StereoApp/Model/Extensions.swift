//
//  Extensions.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 16.12.2022.
//

import Foundation
import UIKit

extension UIButton {
  func buttonPressed() {
    self.isEnabled = false
    self.alpha = 0.5
    
    UIView.animate(withDuration: 1, animations: {
      self.alpha = 1
    }) { completion in
      self.isEnabled = true
    }
  }
  
  
}
