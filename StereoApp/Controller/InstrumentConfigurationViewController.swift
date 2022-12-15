//
//  InstrumentConfigurationViewController.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 15.12.2022.
//

import SnapKit
import UIKit

final class InstrumentConfigurationViewController: UIViewController {
  
  private var orchestra: Orchestra?
  private var indexOfElement: Int?
  private var instrumnet: Instrument?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
    setup()
  }
  
  private func setupNavigationController() {
    self.title = "Configure instrument"
    self.navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
    view.backgroundColor = Colors.background
  }
  
  private func setup() {
    
  }
  
  public func configure(with orchestra: Orchestra, index: Int?, instrument: Instrument) {
    self.orchestra = orchestra
    self.indexOfElement = index
    self.instrumnet = instrument
    
    print(orchestra)
  }
  
  @objc private func doneButtonPressed() {
    orchestra?.instruments[indexOfElement ?? 0].image = instrumnet?.image
    
    navigationController?.popToRootViewController(animated: true)
  }
}
