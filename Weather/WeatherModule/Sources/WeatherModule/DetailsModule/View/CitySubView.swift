//
//  File.swift
//  
//
//  Created by Данила on 05.12.2022.
//

import UIKit
import SnapKit

final class CitySubView: UIView {
    
    private let nameCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "Name of City"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let isCapitalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 11
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        return imageView
    }()
    
    
    
    private  let twoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let populationTextCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.textAlignment  = .right
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let populationCityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.textAlignment  = .left
        label.text = "999999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let seasonTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment  = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.text = "Season:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment  = .left
        label.text = "summer"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    

    // MARK: - tempView
    private let tempView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let perceivedLabel: UILabel = {
        let label = UILabel()
        label.text = "Perceived"
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "temperature"
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "day:"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTextLabel: UILabel = {
        let label = UILabel()
        label.text = "night:"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayTempLabel: UILabel = {
        let label = UILabel()
        label.text = "36"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dayCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-12"
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nightCLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2103}"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment  = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let conditionTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.textColor = .gray
        label.textAlignment  = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.baselineAdjustment = .alignBaselines
        label.text = "Condition:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "thunderstorm-with-rain"
        label.textAlignment  = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    // MARK: - windView
    private let windView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let windSpeedTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.baselineAdjustment = .alignBaselines
        label.textAlignment  = .right
        label.text = "Wind speed:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "120 m/c"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windDirTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment  = .right
        label.text = "Direction:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let windDirLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.02
        label.baselineAdjustment = .alignBaselines
        label.text = "southwest"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let pressureMmTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment  = .right
        label.text = "Pressure:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let pressureMmLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "100 mm"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let humidityTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment  = .right
        label.text = "Humidity:"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment  = .left
        label.text = "12 %"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
                
        self.addSubview(nameCityLabel)
        self.addSubview(isCapitalImageView)

        self.addSubview(twoView)
        self.addSubview(tempView)
        self.addSubview(windView)
        
        twoView.addSubview(populationTextCityLabel)
        twoView.addSubview(populationCityLabel)
        twoView.addSubview(seasonTextLabel)
        twoView.addSubview(seasonLabel)
        
        tempView.addSubview(perceivedLabel)
        tempView.addSubview(temperatureLabel)
        tempView.addSubview(dayTextLabel)
        tempView.addSubview(dayTempLabel)
        tempView.addSubview(dayCLabel)
        tempView.addSubview(nightTextLabel)
        tempView.addSubview(nightTempLabel)
        tempView.addSubview(nightCLabel)
        tempView.addSubview(conditionTextLabel)
        tempView.addSubview(conditionLabel)
        
        windView.addSubview(pressureMmTextLabel)
        windView.addSubview(pressureMmLabel)
        windView.addSubview(humidityTextLabel)
        windView.addSubview(humidityLabel)
        windView.addSubview(windSpeedTextLabel)
        windView.addSubview(windSpeedLabel)
        windView.addSubview(windDirTextLabel)
        windView.addSubview(windDirLabel)
        
        
        isCapitalImageView.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.top.equalTo(6)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        nameCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(isCapitalImageView.snp.trailing).offset(6)
            make.top.equalTo(6)
            make.height.equalTo(26)
            make.trailing.equalTo(-8)
        }
        
        
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        populationTextCityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(tempView.snp.centerX).offset(-2)
        }
        populationCityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(tempView.snp.centerX).offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-4)
        }
        seasonTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(self.snp.centerX).offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-12)
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(seasonTextLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(8)
        }
        
        
        
        // MARK: - tempView.snp.makeConstraints
        tempView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX).offset(-16)
            make.bottom.equalToSuperview()
        }
        perceivedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dayTextLabel.snp.bottom)
            make.height.equalTo(17)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(dayTextLabel.snp.leading).offset(-2)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nightTextLabel.snp.bottom)
            make.height.equalTo(17)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(dayTextLabel.snp.leading).offset(-2)
        }
        
        dayTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(17)
            make.leading.equalTo(conditionLabel.snp.leading).offset(4)
            make.trailing.equalTo(tempView.snp.centerX).offset(38)
        }
        dayTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextLabel.snp.centerY)
            make.height.equalTo(19)
            make.leading.equalTo(dayTextLabel.snp.trailing) //.offset(2)
            make.width.equalTo(26)
        }
        dayCLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(dayTempLabel.snp.trailing)
        }
        
        nightTextLabel.snp.makeConstraints { make in
            make.top.equalTo(dayTextLabel.snp.bottom).offset(4)
            make.height.equalTo(17)
            make.leading.equalTo(dayTextLabel.snp.leading)
            make.trailing.equalTo(dayTextLabel.snp.trailing)
        }
        nightTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nightTextLabel.snp.centerY)
            make.height.equalTo(19)
            make.leading.equalTo(dayTempLabel.snp.leading)
            make.width.equalTo(26)
        }
        nightCLabel.snp.makeConstraints { make in
            make.top.equalTo(nightTextLabel.snp.top)
            make.height.equalTo(12)
            make.leading.equalTo(nightTempLabel.snp.trailing)
        }
     
        conditionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nightTextLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(tempView.snp.centerX).offset(-4)
            make.height.equalTo(20)
        }
        conditionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(conditionTextLabel.snp.centerY)
            make.leading.equalTo(conditionTextLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        
        
        // MARK: - windView.snp.makeConstraints
        windView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.centerX).offset(-16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        pressureMmTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-18)
            make.height.equalTo(20)
        }
        pressureMmLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pressureMmTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        humidityTextLabel.snp.makeConstraints { make in
            make.top.equalTo(pressureMmTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-18)
            make.height.equalTo(20)
        }
        humidityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(humidityTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windSpeedTextLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-18)
            make.height.equalTo(20)
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windSpeedTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        windDirTextLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedTextLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(windView.snp.centerX).offset(-18)
            make.height.equalTo(20)
        }
        windDirLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windDirTextLabel.snp.bottom)
            make.leading.equalTo(windView.snp.centerX).offset(-8)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
    }
    
    public func configureCityView(_ model: CityViewModel) {
        
        nameCityLabel.text = model.cityName
        
        if model.isCapital {
            isCapitalImageView.isHidden = false
        }
        
        if model.populationOfCity == "" {
            populationTextCityLabel.isHidden = true
            populationCityLabel.isHidden = true
        } else {
            populationTextCityLabel.isHidden = false
            populationCityLabel.isHidden = false
            populationCityLabel.text = model.populationOfCity
        }
    }
    
    public func configureWeatherView(_ model: FactViewModel) {
        
        seasonLabel.text = model.season
        dayTempLabel.fadeTransition(0.5)
        dayTempLabel.text = model.dayTemp
        nightTempLabel.fadeTransition(0.5)
        nightTempLabel.text = model.nightTemp
        conditionLabel.fadeTransition(0.5)
        conditionLabel.text = model.condition
        windSpeedLabel.fadeTransition(0.5)
        windSpeedLabel.text =  model.windSpeed
        humidityLabel.fadeTransition(0.5)
        humidityLabel.text = model.humidity
        windDirLabel.fadeTransition(0.5)
        windDirLabel.text = model.windDir
        pressureMmLabel.fadeTransition(0.5)
        pressureMmLabel.text = model.pressureMm
    }
}
