//
//  File.swift
//  
//
//  Created by Данила on 05.12.2022.
//

import Foundation
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
        label.textAlignment  = .left
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
        label.textAlignment  = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
//    private let descriptionTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "Nine days since the killings of four college students attending the University of Idaho, police have not arrested any suspect, but are \"definitely making progress,\" according to an outside public information officer."
//        textView.font = UIFont.systemFont(ofSize: 15)
//        textView.textColor = .systemGray
//        textView.translatesAutoresizingMaskIntoConstraints = false
//
//        return textView
//    }()
    
    // MARK: - Init
    override init( style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init( style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.selectionStyle = .none
        
        self.addSubview(dateLabel)
        self.addSubview(titleLabel)
       // self.addSubview(descriptionTextView)
        
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
        
//        descriptionTextView.snp.makeConstraints { make in
//            make.leading.equalTo(8)
//            make.trailing.equalTo(-8)
//            make.top.equalTo(titleLabel.snp.bottom)
//            make.bottom.equalTo(0)
//        }
    }
    
    
    public func configureCell(_ viewModel: NewsViewModel) {
        
        dateLabel.text = viewModel.date
        titleLabel.text = viewModel.title
     //   descriptionTextView.text = viewModel.description.htmlToString
        
    }
}
