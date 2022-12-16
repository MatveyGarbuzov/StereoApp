//
//  MainController.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 14.12.2022.
//

import SnapKit
import UIKit

class MainController: UIViewController {
  
  // MARK: Fields
  private var orchestra = Orchestra()
  private var audioPlayer = AudioPlayerController()
  
  private var stackView: UIStackView?
  
  lazy private var playButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.backgroundColor = .opaqueSeparator
    button.setTitle("Play", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
    button.layer.cornerRadius = 10
    button.setTitleColor(.label, for: .normal)
    
    button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    
    return button
  }()
  
  lazy private var resetButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .opaqueSeparator
    button.setTitle("Reset", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
    button.layer.cornerRadius = 10
    button.setTitleColor(.label, for: .normal)
    
    button.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    
    
    return button
  }()
  
  lazy private var mainView: UIView = {
    let view = UIView()
    return view
  }()
  
  lazy var instrumentsView: [UIImageView] = {
    var views: [UIImageView] = []
    
    for i in 0..<orchestra.instruments.count {
      let view = UIImageView()
      view.isUserInteractionEnabled = true
      view.tag = i
      let gesture = UITapGestureRecognizer(target: self, action:  #selector(instrumentPressed))
      view.addGestureRecognizer(gesture)
      self.mainView.addSubview(view)
      views.append(view)
    }
    return views
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateSelectedInstruments()
  }
  
  private func updateSelectedInstruments() {
    for i in 0..<instrumentsView.count {
      instrumentsView[i].image = orchestra.instruments[i].image
    }
  }
  
  private func setupNavigationController() {
    view.backgroundColor = .systemBackground
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.text]
    navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    
    navigationItem.title = "Stereo Audio App"
  }
  
  private func setup() {
    view.addSubview(mainView)
    
    setupMainView()
    setupButtons()
  }
  
  private func setupMainView() {
    mainView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(50)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
    }
    
    
    lazy var personCircleView: UIView = {
      let view = UIView()
      view.backgroundColor = .opaqueSeparator
      view.layer.cornerRadius = 50
      return view
    }()
    
    mainView.addSubview(personCircleView)
    personCircleView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalTo(100)
    }
    
    do {
      instrumentsView.forEach { instrument in
        instrument.snp.makeConstraints { make in
          make.height.width.equalTo(40)
        }
      }
      
      instrumentsView[0].snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.leading.equalToSuperview().inset(30)
      }
      
      instrumentsView[1].snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalToSuperview().inset(100)
      }
      
      instrumentsView[2].snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.trailing.equalToSuperview().inset(30)
      }
      
      instrumentsView[3].snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().inset(100)
      }
    }
    
  }
  
  private func setupButtons() {
    stackView = UIStackView(arrangedSubviews: [playButton, resetButton])
    view.addSubview(stackView!)
    stackView!.axis = .horizontal
    stackView!.spacing = 5
    stackView!.distribution = .fillEqually
    
    playButton.snp.makeConstraints { make in
      make.height.equalToSuperview()
    }
    
    resetButton.snp.makeConstraints { make in
      make.height.equalToSuperview()
    }
    
    stackView!.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(40)
      make.height.equalTo(60)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(30)
    }
  }
  
  @objc private func playButtonPressed(_ sender: UIView?) {
    guard let button = sender as? UIButton else { return }
    
    button.buttonPressed()
    audioPlayer.play(orchestra: self.orchestra)
  }
  
  @objc private func resetButtonPressed(_ sender: UIView?) {
    guard let button = sender as? UIButton else { return }
    button.buttonPressed()
    
    for i in 0..<instrumentsView.count {
      orchestra.instruments[i] = Instrument(name: .empty, image: UIImage(systemName: "clear"))
    }
    updateSelectedInstruments()
  }
  
  @objc private func instrumentPressed(sender: UITapGestureRecognizer) {
    let instrumentViewController = ListOfInstrumentsViewController()
  
    instrumentViewController.configure(with: sender.view?.tag ?? 0, orchestra: orchestra)
    navigationController?.pushViewController(instrumentViewController, animated: true)
  }
  
}
