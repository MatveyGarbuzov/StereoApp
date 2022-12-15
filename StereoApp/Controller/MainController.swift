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
  
  lazy private var playButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.backgroundColor = .red
    button.setTitle("Play", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
    button.layer.cornerRadius = 10
    
    button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    
    return button
  }()
  
  lazy private var mainView: UIView = {
    let view = UIView()
    return view
  }()
  
  lazy var instrumentsView: [UIImageView] = {
    var views: [UIImageView] = []
    
    for i in 0...orchestra.instruments.count-1 {
      let view = UIImageView()
      view.isUserInteractionEnabled = true
      view.backgroundColor = .gray
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
    view.backgroundColor = Colors.background
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.black]
    navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    
    navigationItem.title = "Stereo Audio App"
  }
  
  private func setup() {
    view.addSubview(mainView)
    view.addSubview(playButton)
    
    setupMainView()
    setupPlayButton()
  }
  
  private func setupMainView() {
    mainView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(50)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(playButton.snp.top)
    }
    
    
    lazy var personCircleView: UIView = {
      let view = UIView()
      view.backgroundColor = .red
      view.layer.cornerRadius = 50
      return view
    }()
    
    mainView.addSubview(personCircleView)
    personCircleView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalTo(100)
    }
    
//    lazy var instrumentsView: [UIView] = {
//      var views: [UIView] = []
//
//      for i in 0...orchestra.instruments.count-1 {
//        let view = UIView()
//        view.backgroundColor = .purple
//        view.tag = i
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(instrumentPressed))
//        view.addGestureRecognizer(gesture)
//        self.mainView.addSubview(view)
//        views.append(view)
//      }
//      return views
//    }()
    
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
  
  private func setupPlayButton() {
    playButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(80)
      make.height.equalTo(60)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(30)
    }
  }
  
  
  @objc private func playButtonPressed() {
    print("A")
  }
  
  @objc private func instrumentPressed(sender: UITapGestureRecognizer) {
    print(sender.view?.tag ?? 0)
    
    let instrumentViewController = ListOfInstrumentsViewController()
  
    instrumentViewController.configure(with: sender.view?.tag ?? 0, orchestra: orchestra)
    navigationController?.pushViewController(instrumentViewController, animated: true)
  }
  
}
