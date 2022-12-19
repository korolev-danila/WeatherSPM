//
//  File.swift
//  
//
//  Created by Данила on 08.12.2022.
//

import UIKit
import SnapKit

final class ShimmerView: UIView {
    private let backColor = UIColor.systemBackground
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bigView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cityView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cityLayer = CAGradientLayer()
    private let cell1View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell1Layer = CAGradientLayer()
    private let cell2View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell2Layer = CAGradientLayer()
    private let cell3View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell3Layer = CAGradientLayer()
    private let cell4View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell4Layer = CAGradientLayer()
    private let cell5View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell5Layer = CAGradientLayer()
    private let cell6View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell6Layer = CAGradientLayer()
    private let cell7View: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cell7Layer = CAGradientLayer()
    private let newsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let newsLayer = CAGradientLayer()
    private let imageViewHConst: CGFloat = 172
    private let imageToCityConst: CGFloat = -12
    private let cityViewHConst: CGFloat = 172
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        addSubview(topView)
        addSubview(bigView)
          
        bigView.addSubview(cityView)
        bigView.addSubview(cell1View)
        bigView.addSubview(cell2View)
        bigView.addSubview(cell3View)
        bigView.addSubview(cell4View)
        bigView.addSubview(cell5View)
        bigView.addSubview(cell6View)
        bigView.addSubview(cell7View)
        bigView.addSubview(newsView)
        
        bigView.backgroundColor = .tertiaryLabel
        cityView.backgroundColor = backColor
        cell1View.backgroundColor = backColor
        cell2View.backgroundColor = backColor
        cell3View.backgroundColor = backColor
        cell4View.backgroundColor = backColor
        cell5View.backgroundColor = backColor
        cell6View.backgroundColor = backColor
        cell7View.backgroundColor = backColor
        newsView.backgroundColor = backColor
        
        topView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalToSuperview()
            make.height.equalTo(imageViewHConst)
        }
        bigView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(imageToCityConst)
            make.height.equalTo(self.snp.height)
        }
        cityView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
            make.height.equalTo(cityViewHConst)
        }
        cell1View.snp.makeConstraints { make in
            make.leading.equalTo(bigView.snp.leading).offset(8)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell2View.snp.makeConstraints { make in
            make.leading.equalTo(cell1View.snp.trailing).offset(12)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell3View.snp.makeConstraints { make in
            make.leading.equalTo(cell2View.snp.trailing).offset(14)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell4View.snp.makeConstraints { make in
            make.leading.equalTo(cell3View.snp.trailing).offset(12)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell5View.snp.makeConstraints { make in
            make.leading.equalTo(cell4View.snp.trailing).offset(12)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell6View.snp.makeConstraints { make in
            make.leading.equalTo(cell5View.snp.trailing).offset(14)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        cell7View.snp.makeConstraints { make in
            make.leading.equalTo(cell6View.snp.trailing).offset(12)
            make.top.equalTo(cityView.snp.bottom).offset(4)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        newsView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.height.equalTo(400)
            make.top.equalTo(cell1View.snp.bottom).offset(8)
        }
    }
    
    private func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.7
        return animation
    }
    
    // MARK: - Public method
    func startShimmerEffect() {
        let gradientColorOne: CGColor = backColor.cgColor
        let gradientColorTwo: CGColor = UIColor.secondarySystemBackground.cgColor
        let animation = addAnimation()
        
        func config(view: UIView, layer: CAGradientLayer) {
            layer.frame = view.bounds
            layer.cornerRadius = view.layer.cornerRadius
            layer.startPoint = CGPoint(x: 0.0, y: 1.0)
            layer.endPoint = CGPoint(x: 1.0, y: 1.0)
            layer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
            layer.locations = [0.0, 0.5, 1.0]
            view.layer.addSublayer(layer)
            layer.add(animation, forKey: animation.keyPath)
        }
        
        config(view: cityView, layer: cityLayer)
        config(view: cell1View, layer: cell1Layer)
        config(view: cell2View, layer: cell2Layer)
        config(view: cell3View, layer: cell3Layer)
        config(view: cell4View, layer: cell4Layer)
        config(view: cell5View, layer: cell5Layer)
        config(view: cell6View, layer: cell6Layer)
        config(view: cell7View, layer: cell7Layer)
        config(view: newsView, layer: newsLayer)
    }
    
    func stopShimmerEffect() {
        cityView.layer.sublayers?.removeAll()
        cell1View.layer.sublayers?.removeAll()
        cell2View.layer.sublayers?.removeAll()
        cell3View.layer.sublayers?.removeAll()
        cell4View.layer.sublayers?.removeAll()
        cell5View.layer.sublayers?.removeAll()
        cell6View.layer.sublayers?.removeAll()
        cell7View.layer.sublayers?.removeAll()
        newsView.layer.sublayers?.removeAll()
    }
}
