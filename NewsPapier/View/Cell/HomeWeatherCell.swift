//
//  DiscoverCategorySectionsCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

class HomeWeatherCell: UICollectionViewCell {
    
    static let identifier   = "HomeWeatherCell"
    
    private let cityName = UILabel(autoLayout: false,
                                   font: Theme.h3Title,
                                   color: Theme.primaryText,
                                   text: "",
                                   textAlignment: .center)
    
    private let weatherIcon = UIImageView(contentMode: .scaleAspectFill,
                                          autoLayout: false,
                                          clipsToBounds: true)
    
    private let weatherLabel = UILabel(autoLayout: false,
                                       font: Theme.h0Title,
                                       color: Theme.primaryText,
                                       text: "",
                                       textAlignment: .center)
    
    private let temp = UILabel(autoLayout: false,
                               font: Theme.body4,
                               color: Theme.primaryText,
                               text: "",
                               textAlignment: .center)
    
    func setWeather(_ weather: WeatherResponse){
        
        cityName.text = weather.name
        
        var urlString = ""
        
        if let _weather = weather.weather.first{
            
            weatherLabel.text = _weather.main
            urlString = Preferences.weatherIconUrl + _weather.icon + Preferences.weatherIconUrlResource
            
        }
        
        guard let imageUrl      = URL(string: urlString) else {return}
        
        weatherIcon.sd_setImage(with: imageUrl)
        
        temp.text = "\(weather.minTemp)\u{00B0} - \(weather.maxTemp)\u{00B0}"
    }
    
    private lazy var stack = VStackView([cityName, weatherIcon, temp],
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
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.addSubview(categoryImageView)
        contentView.addSubview(stack)
//
        applyConstraints()
        backgroundColor = Theme.tertiaryBackground
        layer.cornerRadius = Radius.r2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
