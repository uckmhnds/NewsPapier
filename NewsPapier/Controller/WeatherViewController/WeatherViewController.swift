//
//  WeatherViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let tableView = WeatherTableView()
    
    // MARK: - Network
    
    var weatherResponseDict = [Dictionary<WeatherCase, WeatherResponse>.Element]()
    
    private var isLoading: Bool = true
    private let dispatchGroup = DispatchGroup()
    
    private func addSubviews(){
        view.addSubview(tableView)
    }
    
    private func delegateMethods(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func loadLocalNews(){
        
        for weather in WeatherCase.allCases{
            
            self.dispatchGroup.enter()
            
            DispatchQueue.main.async {
                
                if let response = DecodeLocal.shared.fetch(fileName: weather.code) as WeatherResponse?
                {
                    let fetchedData: Dictionary<WeatherCase, WeatherResponse>.Element = (key: weather, value: response)
                    self.weatherResponseDict.append(fetchedData)
                }
                
                self.dispatchGroup.leave()
            }
            
        }
        
        self.dispatchGroup.notify(queue: .main){
            
            self.isLoading = false
            self.tableView.reloadData()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLocalNews()
        self.addSubviews()
        self.delegateMethods()
        
        
        if let navController = self.navigationController{
            if navController.hidesBarsOnSwipe{
                print("true")
            }else{
                print("false")
            }
        }
        
        self.title = Preferences.weatherViewControllerTitle
        self.view.backgroundColor = Theme.primaryBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
//        tableView.anchor(top: view.bottomAnchor,
//                         leading: view.leadingAnchor,
//                         bottom: view.bottomAnchor,
//                         trailing: view.trailingAnchor)
        
    }

}

