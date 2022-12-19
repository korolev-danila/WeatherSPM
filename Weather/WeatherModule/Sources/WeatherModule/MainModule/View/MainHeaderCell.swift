//
//  File.swift
//  
//
//  Created by Данила on 30.11.2022.
//

import UIKit

final class HeaderView: UIView {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        return label
    }()
    private let activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        return activity
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        return imageView
    }()
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let color1 = UIColor.gray.withAlphaComponent(0.7).cgColor
        gradient.colors = [color1, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.85, y: 1.0)
        return gradient
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private method
    private func setupViews(_ heightOfCell: CGFloat) {
        backgroundColor = UIColor.clear
        layer.cornerRadius = 15.0
        clipsToBounds = true
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 1)
       
        addSubview(activityView)
        addSubview(imageView)
        addSubview(headerLabel)
        
        activityView.frame = CGRect(x: 1, y: 1,
                                    width: heightOfCell / 2 - 2,
                                    height: heightOfCell / 2 - 2)
        imageView.frame = CGRect(x: 1, y: 1,
                                 width: heightOfCell / 2 - 2,
                                 height: heightOfCell / 2 - 2)
        headerLabel.frame = CGRect(x: heightOfCell / 2, y: 0,
                                   width: frame.width - heightOfCell*1.25,
                                   height: heightOfCell / 2)
    }
    
    // MARK: - Public method
    func settingCell(_ viewModel: HeaderCellViewModel) {
        headerLabel.text = viewModel.name
        
        if let image = UIImage(data: viewModel.imgData) {
            activityView.stopAnimating()
            imageView.image = image.resize(60)
        } else if !activityView.isAnimating {
            activityView.startAnimating()
        }
    }
}
