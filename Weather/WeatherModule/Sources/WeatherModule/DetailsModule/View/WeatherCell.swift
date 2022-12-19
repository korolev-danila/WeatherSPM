//
//  File.swift
//  
//
//  Created by Данила on 26.11.2022.
//

import UIKit
import SnapKit
import WebKit

final class WeatherCell: UICollectionViewCell {
    private let vcWebDelegate = VCWebDelegate()
    private let webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let wv = WKWebView(frame: .zero, configuration: configuration)
        wv.scrollView.isScrollEnabled = false
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.contentMode = .center
        wv.isOpaque = false
        wv.isHidden = true
        wv.isUserInteractionEnabled = false
        wv.backgroundColor = .clear
        wv.allowsBackForwardNavigationGestures = true
        wv.allowsLinkPreview = true
        return wv
    }()
    private let iconActivityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.contentMode = .center
        activity.backgroundColor = .clear
        activity.isHidden = true
        return activity
    }()
    private let dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Mon"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "27.11"
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let tempView: UIView = {
        let view = UIView()
        return view
    }()
    private let dayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Day:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nightTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Night:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.text = "36"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dayCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-12"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nightCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
            setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(dayOfTheWeekLabel)
        contentView.addSubview(tempView)
        contentView.addSubview(webView)
        contentView.addSubview(iconActivityView)
        
        vcWebDelegate.webView = webView
        vcWebDelegate.iconActivityView = iconActivityView
        
        tempView.addSubview(dayTextLabel)
        tempView.addSubview(dayTempLabel)
        tempView.addSubview(dayCLabel)
        tempView.addSubview(nightTextLabel)
        tempView.addSubview(nightTempLabel)
        tempView.addSubview(nightCLabel)
        
        dayOfTheWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.leading.equalTo(5)
            make.trailing.equalTo(contentView.snp.centerX).offset(-4)
            make.height.equalTo(15)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.trailing.equalTo(-5)
            make.leading.equalTo(dayOfTheWeekLabel.snp.trailing).offset(4)
            make.height.equalTo(15)
        }
        
        // MARK: - tempView.snp.makeConstraints
        tempView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(dayOfTheWeekLabel.snp.bottom).offset(2)
            make.height.equalTo(30)
        }
        dayTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(14)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(contentView.snp.centerX).offset(-2)
        }
        dayTempLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dayTextLabel.snp.bottom)
            make.height.equalTo(14)
            make.leading.equalTo(dayTextLabel.snp.trailing).offset(2)
            make.width.equalTo(20)
        }
        dayCLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTempLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(dayTempLabel.snp.trailing)
        }
        nightTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom)
            make.height.equalTo(14)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(contentView.snp.centerX).offset(-2)
        }
        nightTempLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nightTextLabel.snp.bottom)
            make.height.equalTo(14)
            make.leading.equalTo(nightTextLabel.snp.trailing).offset(2)
            make.width.equalTo(20)
        }
        nightCLabel.snp.makeConstraints { make in
            make.top.equalTo(nightTempLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(nightTempLabel.snp.trailing)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
        iconActivityView.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    // MARK: - configureCell
    func configureCell(_ viewModel: ForecastViewModel) {
        dayTempLabel.text = viewModel.dayTemp
        nightTempLabel.text = viewModel.nightTemp
        dateLabel.text = viewModel.date
        dayOfTheWeekLabel.text = viewModel.week
        
        if viewModel.svgStr != "" {
            iconActivityView.isHidden = false
            iconActivityView.startAnimating()
            webView.isHidden = true
            vcWebDelegate.setDelegate()
            webView.loadHTMLString(viewModel.svgStr, baseURL: nil)
        }
    }
}

// MARK: - VCWebDelegate
final class VCWebDelegate: UIViewController {
    weak var iconActivityView: UIActivityIndicatorView?
    weak var webView: WKWebView?
   
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit VCWebDelegate")
    }
    
    func setDelegate() {
        if webView != nil {
            webView?.navigationDelegate = self
        } else {
            print("webView nil")
        }
    }
}

// MARK: - WKNavigationDelegate
extension VCWebDelegate: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        self.webView?.isHidden = false
        self.iconActivityView?.stopAnimating()
    }
}
