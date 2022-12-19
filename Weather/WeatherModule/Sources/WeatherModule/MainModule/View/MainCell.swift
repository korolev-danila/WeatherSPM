//
//  File.swift
//  
//
//  Created by Данила on 21.11.2022.
//

import UIKit
import SnapKit

protocol MainViewCellDelegate: AnyObject {
    func delete(cell: MainCell)
}

final class MainCell: UITableViewCell {
    weak var delegate: MainViewCellDelegate?
    private var deleteIsHidden = true {
        didSet {
            deleteButton.isHidden = deleteIsHidden
            deleteButton.isEnabled = !deleteIsHidden
        }
    }
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10:00"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let cLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        return activity
    }()
    private let deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark.circle",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,
                                                                           weight: .semibold))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .red
        button.layer.cornerRadius = 25
        button.clipsToBounds = false
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonTap() {
        delegate?.delete(cell: self)
    }
    
    // MARK: - Private method
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        
        contentView.addSubview(deleteButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(cLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(activityView)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.trailing.equalTo(contentView.snp.centerX)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(-15)
            make.width.equalTo(contentView.snp.height)
            make.height.equalTo(contentView.snp.height)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        tempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(cLabel.snp.leading)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        cLabel.snp.makeConstraints { make in
            make.trailing.equalTo(timeLabel.snp.leading).offset(-10)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-8)
            make.width.equalTo(50)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        activityView.snp.makeConstraints { make in
            make.trailing.equalTo(timeLabel.snp.leading).offset(-14)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
    }
    
    // MARK: - configureCell
    func configureCell(_ viewModel: MainCellViewModel, deleteIsHid: Bool) {
        if viewModel.temp == nil {
            if !activityView.isAnimating {
                activityView.startAnimating()
                timeLabel.isHidden = true
                tempLabel.isHidden = true
                cLabel.isHidden = true
            }
        } else {
            activityView.stopAnimating()
            tempLabel.text = viewModel.temp
            timeLabel.text = viewModel.time
            timeLabel.isHidden = false
            tempLabel.isHidden = false
            cLabel.isHidden = false
        }
        nameLabel.text = viewModel.name
        deleteIsHidden = deleteIsHid
    }
}
