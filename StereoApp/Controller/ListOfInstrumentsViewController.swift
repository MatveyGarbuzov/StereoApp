//
//  InstrumentViewController.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 15.12.2022.
//

import SnapKit
import UIKit

class ListOfInstrumentsViewController: UIViewController {
  
  // MARK: Fields
  private var allInstruments = AllInstruments()
  private var orchestra: Orchestra?
  private var indexOfElement: Int?
  
  lazy private var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    
    tableView.register(InstrumentCell.self,
                       forCellReuseIdentifier: InstrumentCell.reuseIdentifier)
    return tableView
  }()
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
    setupTableView()
    print(InstrumentName.allCases.count)
  }
  
  // MARK: Private functions
  
  private func setupNavigationController() {
    self.title = "Choose instrument"
    self.navigationItem.largeTitleDisplayMode = .never
    view.backgroundColor = .systemBackground
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: Public functions
  
  public func configure(with index: Int, orchestra: Orchestra) {
    self.orchestra = orchestra
    self.indexOfElement = index
  }
}

extension ListOfInstrumentsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allInstruments.list.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let noteCell = tableView.dequeueReusableCell(
      withIdentifier: InstrumentCell.reuseIdentifier, for: indexPath) as? InstrumentCell {
      noteCell.configure(with: allInstruments.list[indexPath.row])
      return noteCell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      navigationController?.popToRootViewController(animated: true)
      orchestra?.instruments[indexOfElement!] = Instrument(name: .empty, image: UIImage(systemName: "clear"))
    } else {
      let instrumentConfigVC = InstrumentConfigurationViewController()
      instrumentConfigVC.configure(with: orchestra!, index: indexOfElement, instrument: allInstruments.list[indexPath.row])
      navigationController?.pushViewController(instrumentConfigVC, animated: true)
    }
  }
}
