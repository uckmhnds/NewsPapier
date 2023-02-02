//
//  WeatherViewController+Data.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/29/23.
//

import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weatherResponseDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell()}
        
        let index = indexPath.row

        let dict = self.weatherResponseDict[index]

        cell.setWeather(dict.value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        
        let dict = self.weatherResponseDict[index]
        
        let viewController = WeatherDetailViewController()
        
        if let navController = self.navigationController{
            navController.pushViewController(viewController, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Preferences.weatherTableControllerHeight
    }
    
}
