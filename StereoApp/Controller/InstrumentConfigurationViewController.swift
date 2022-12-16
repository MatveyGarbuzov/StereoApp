//
//  InstrumentConfigurationViewController.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 15.12.2022.
//

import SnapKit
import UIKit

final class InstrumentConfigurationViewController: UIViewController {
  
  // MARK: Fields
  
  private var orchestra: Orchestra?
  private var indexOfElement: Int?
  private var selectedInstrument: Instrument?
  
  lazy private var mainView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  lazy private var volumeSliderView = createSliderView(minValue: 0.0, maxValue: 1.0, text: "Volume", tag: 0)
  lazy private var sideSliderView = createSliderView(minValue: -1.0, maxValue: 1.0, text: "Side(L/R)", tag: 1)
  
  // MARK: Lyfe Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
    setupMainView()
  }
  
  // MARK: Private functions
  
  private func setupNavigationController() {
    self.title = "Configure instrument"
    self.navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
    view.backgroundColor = .systemBackground
  }
  
  private func setupMainView() {
    view.addSubview(mainView)
    
    mainView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    setupSliderStack()
  }
  
  private func setupSliderStack() {
    volumeSliderView.snp.makeConstraints { make in
      make.height.equalTo(50)
    }
    
    sideSliderView.snp.makeConstraints { make in
      make.height.equalTo(50)
    }
    
    let spacer = UIView()
    
    let stack = UIStackView(arrangedSubviews: [volumeSliderView, sideSliderView, spacer])
    mainView.addSubview(stack)
    stack.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(10)
    }
    stack.axis = .vertical
    stack.spacing = 5
  }
  
  private func createSliderView(minValue: Float, maxValue: Float, text: String, tag: Int) -> UIStackView {
    let nameLabel: UILabel = {
      let label = UILabel()
      label.text = text
      
      return label
    }()
    
    let minLabel: UILabel = {
      let label = UILabel()
      label.text = String(minValue)
      return label
    }()
    
    let slider: UISlider = {
      let slider = UISlider()
      slider.minimumValue = minValue
      slider.maximumValue = maxValue
      slider.isContinuous = true
      slider.tag = tag
      slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
      return slider
    }()
    
    let maxLabel: UILabel = {
      let label = UILabel()
      label.text = String(maxValue)
      return label
    }()
    
    
    let sliderStackView = UIStackView(arrangedSubviews: [nameLabel, minLabel, slider, maxLabel])
    nameLabel.snp.makeConstraints { make in
      make.width.equalTo(90)
    }
    minLabel.snp.makeConstraints { make in
      make.width.equalTo(30)
    }
    maxLabel.snp.makeConstraints { make in
      make.width.equalTo(30)
    }
    
    sliderStackView.distribution = .fillProportionally
    sliderStackView.layer.cornerRadius = 5
    sliderStackView.backgroundColor = .systemGray6
    mainView.addSubview(sliderStackView)
    
    return sliderStackView
  }
  
  private func saveConfiguration() {
    orchestra?.instruments[indexOfElement ?? 0] = selectedInstrument ?? Instrument()
  }
  
  // MARK: Public functions
  
  public func configure(with orchestra: Orchestra, index: Int?, instrument: Instrument) {
    self.orchestra = orchestra
    self.indexOfElement = index
    self.selectedInstrument = instrument
    
    print(orchestra)
  }
  
  @objc private func doneButtonPressed() {
    saveConfiguration()
    
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc private func sliderMoved(_ sender: UISlider!) {
    let step: Float = 0.1
    let roundedStepValue = round(sender.value / step) * step
    sender.value = roundedStepValue
    
    switch sender.tag {
    case 0: // VOLUME
      selectedInstrument?.volume = roundedStepValue
    case 1: // SIDE
      selectedInstrument?.side = roundedStepValue
    default:
      return
    }
  }
}
