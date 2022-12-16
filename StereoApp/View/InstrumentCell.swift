//
//  InstrumentCell.swift
//  StereoApp
//
//  Created by Matvey Garbuzov on 16.12.2022.
//

import SnapKit
import UIKit

final class InstrumentCell: UITableViewCell {
  static let reuseIdentifier = "InstrumentCell"
  private let instrumentImageView = UIImageView()
  private let instrumentTitleLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }
  
  func setupView() {
    contentView.backgroundColor = .systemGray6
    contentView.layer.cornerRadius = 15
//    backgroundColor = .red//Colors.background
    setupImageView()
    setupTitleLabel()
  }
  
  func setupImageView() {
    instrumentImageView.layer.cornerRadius = 8
    instrumentImageView.layer.cornerCurve = .continuous
    instrumentImageView.clipsToBounds = true
    instrumentImageView.contentMode = .scaleToFill
    instrumentImageView.backgroundColor = Colors.lightGray
    
    contentView.addSubview(instrumentImageView)
    instrumentImageView.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview().inset(12)
      make.width.equalTo(instrumentImageView.snp.height)
    }
  }
  
  func setupTitleLabel() {
    instrumentTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
    instrumentTitleLabel.textColor = .label
    instrumentTitleLabel.numberOfLines = 1
    
    contentView.addSubview(instrumentTitleLabel)
    instrumentTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(instrumentImageView.snp.trailing).offset(12)
      make.top.trailing.equalToSuperview().inset(12)
    }
  }
  
  public func configure(with viewModel: Instrument) {
    instrumentTitleLabel.text = viewModel.name?.rawValue
    instrumentImageView.image = viewModel.image
  }
}
