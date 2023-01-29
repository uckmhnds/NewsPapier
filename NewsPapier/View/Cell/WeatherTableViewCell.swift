//
//  WeatherTableViewCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell{
    
    static let identifier = "WeatherTableViewCell"
    
    private let weatherIcon = UIImageView(contentMode: .scaleAspectFill,
                                          autoLayout: false,
                                          clipsToBounds: false)
    
    private let cityName = UILabel(autoLayout: false,
                                   font: Theme.h3Title,
                                   color: Theme.primaryText,
                                   text: "",
                                   textAlignment: .center)
    
    private let weatherLabel = UILabel(autoLayout: false,
                                       font: Theme.h0Title,
                                       color: Theme.primaryText,
                                       text: "",
                                       textAlignment: .center)
    
    private let tempLow = UILabel(autoLayout: false,
                               font: Theme.body4,
                               color: Theme.primaryText,
                               text: "",
                               textAlignment: .center)
    
    private let tempHigh = UILabel(autoLayout: false,
                               font: Theme.body4,
                               color: Theme.primaryText,
                               text: "",
                               textAlignment: .center)
    
    private lazy var tempStack = VStackView([tempLow, tempHigh],
                                            autoLayout: false,
                                            alignment: .center,
                                            distribution: .fillProportionally,
                                            spacing: Spacing.s1)
    
    func setWeather(_ weather: WeatherResponse){
        
        cityName.text = weather.name
        
        var urlString = ""
        
        if let _weather = weather.weather.first{
            
            weatherLabel.text = _weather.main
            urlString = Preferences.weatherIconUrl + _weather.icon + Preferences.weatherIconUrlResource
            
        }
        
        guard let imageUrl      = URL(string: urlString) else {return}
        
        weatherIcon.sd_setImage(with: imageUrl)
        
        tempLow.text = "\(weather.minTemp)\u{00B0}C"
        tempHigh.text = "\(weather.maxTemp)\u{00B0}C"
    }
    
    private lazy var stack = HStackView([weatherIcon, cityName, weatherLabel, tempStack],
                                        autoLayout: false,
                                        alignment: .center,
                                        distribution: .fillProportionally,
                                        spacing: Spacing.s1)
    
    private func applyConstraints(){
        
        stack.anchor(top: topAnchor, leading: leadingAnchor,
                     bottom: bottomAnchor,
                     trailing: trailingAnchor,
                     padding: UIEdgeInsets(top: Padding.p1,
                                           left: Padding.p0,
                                           bottom: Padding.p1,
                                           right: Padding.p0))
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stack)
        
        backgroundColor = Theme.tertiaryBackground
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
