//
//  File.swift
//  
//
//  Created by Данила on 05.12.2022.
//

import UIKit
import SnapKit

final class NewsCell: UITableViewCell {
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "27.11"
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Inside the investigation into who killed 4 college students in Moscow, Idaho"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.top.equalTo(2)
            make.height.equalTo(22)
            make.width.equalTo(34)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.trailing.equalTo(-16)
            make.top.equalTo(2)
            make.bottom.equalTo(0)
        }
    }
    
    func configureCell(_ viewModel: NewsViewModel) {
        dateLabel.text = viewModel.date
        titleLabel.text = viewModel.title
    }
}
