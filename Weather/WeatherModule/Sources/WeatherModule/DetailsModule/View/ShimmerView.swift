//
//  File.swift
//  
//
//  Created by Данила on 08.12.2022.
//

import UIKit
import SnapKit

final class ShimmerView: UIView {
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let bigView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let cityLayer = CAGradientLayer()
    
    private let cell1View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell1Layer = CAGradientLayer()
    
    private let cell2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell2Layer = CAGradientLayer()
    
    private let cell3View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell3Layer = CAGradientLayer()
    
    private let cell4View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell4Layer = CAGradientLayer()
    
    private let cell5View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell5Layer = CAGradientLayer()
    
    private let cell6View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell6Layer = CAGradientLayer()
    
    private let cell7View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let cell7Layer = CAGradientLayer()
    
    private let newsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let newsLayer = CAGradientLayer()
    
    private let imageViewHConst: CGFloat = UIScreen.main.bounds.height / 4
    private let imageToCityConst: CGFloat = -12
    private let cityViewHConst: CGFloat = 172
    
    
    // MARK: - Init
    override init( frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white 
        
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
    public func startShimmerEffect() {
        
        let gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        let gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        
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

        
//        cityLayer.frame = cityView.bounds
//        cityLayer.cornerRadius = cityView.layer.cornerRadius
//        cityLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        cityLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        cityLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        cityLayer.locations = [0.0, 0.5, 1.0]
//        cityView.layer.addSublayer(cityLayer)
        
//        cell1Layer.frame = cell1View.bounds
//        cell1Layer.cornerRadius = cell1View.layer.cornerRadius
//        cell1Layer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        cell1Layer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        cell1Layer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        cell1Layer.locations = [0.0, 0.5, 1.0]
//        cell1View.layer.addSublayer(cell1Layer)
        
//        cell2Layer.frame = cell2View.bounds
//        cell2Layer.cornerRadius = cell2View.layer.cornerRadius
//        cell2Layer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        cell2Layer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        cell2Layer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        cell2Layer.locations = [0.0, 0.5, 1.0]
//        cell2View.layer.addSublayer(cell2Layer)
        
//        cell3Layer.frame = cell3View.bounds
//        cell3Layer.cornerRadius = cell3View.layer.cornerRadius
//        cell3Layer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        cell3Layer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        cell3Layer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        cell3Layer.locations = [0.0, 0.5, 1.0]
//        cell3View.layer.addSublayer(cell3Layer)
//
//        cell4Layer.frame = cell4View.bounds
//        cell4Layer.cornerRadius = cell4View.layer.cornerRadius
//        cell4Layer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        cell4Layer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        cell4Layer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        cell4Layer.locations = [0.0, 0.5, 1.0]
//        cell4View.layer.addSublayer(cell4Layer)
//
//        newsLayer.frame = newsView.bounds
//        newsLayer.cornerRadius = newsView.layer.cornerRadius
//        newsLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        newsLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        newsLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
//        newsLayer.locations = [0.0, 0.5, 1.0]
//        newsView.layer.addSublayer(newsLayer)
//
//
//
//        cityLayer.add(animation, forKey: animation.keyPath)
//        cell1Layer.add(animation, forKey: animation.keyPath)
//        cell2Layer.add(animation, forKey: animation.keyPath)
//        cell3Layer.add(animation, forKey: animation.keyPath)
//        cell4Layer.add(animation, forKey: animation.keyPath)
//        newsLayer.add(animation, forKey: animation.keyPath)
        
    }
    
    public func stopShimmerEffect() {
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

