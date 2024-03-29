//
//  FinanceViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceViewController: UIViewController {
    
    private let tableView = FinanceTableView()
    private let tableControllers = FinanceNavTitleView(frame: .zero)
    
    // MARK: - Network
    
    var financeResponseDict = [Dictionary<FinanceCase, Finance>.Element]()
    
    private var isLoading: Bool = true
    private let dispatchGroup = DispatchGroup()
    
    private func delegateMethods(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func loadLocalNews(){
        
        for finance in FinanceCase.allCases{
            
            self.dispatchGroup.enter()
            
            DispatchQueue.main.async {
                
                if let response = DecodeLocal.shared.fetch(fileName: finance.code) as FinanceResponse?
                {
                    let fetchedData: Dictionary<FinanceCase, Finance>.Element = (key: finance, value: response.data)
                    self.financeResponseDict.append(fetchedData)
                }
                
                self.dispatchGroup.leave()
            }
            
        }
        
        self.dispatchGroup.enter()
        
        DispatchQueue.main.async {
            
            var rank = 1
            #warning("for loop copy pastes")
            self.financeResponseDict.sort(by: {$0.1.marketCap > $1.1.marketCap})
            
            for var finance in self.financeResponseDict{
                
                finance.value.setRank(rank)
                
                self.financeResponseDict.remove(at: rank - 1)
                self.financeResponseDict.insert(finance, at: rank - 1)
                
                rank+=1
                
            }
            self.dispatchGroup.leave()
        }
        
        self.dispatchGroup.notify(queue: .main){
            
            self.isLoading = false
            self.tableView.reloadData()
            
        }
        
    }
    
    @objc private func sortBarButtonAction(){
        
    }
    
    private func configureNavigationBar(){
        
        if let navController = navigationController{
            
            navController.navigationBar.tintColor = .white
            navController.navigationBar.barTintColor = Theme.primaryBackground
            navController.navigationBar.isTranslucent = false
            #warning("not working")
            navController.hidesBarsOnSwipe = true
            
        }
        
        let sortBarImage          = UIImage(systemName: "gearshape")
        
        let sortBar               = UIBarButtonItem(image: sortBarImage,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(sortBarButtonAction))
        
        navigationItem.rightBarButtonItem                   = sortBar
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocalNews()
        
        configureNavigationBar()
        
        view.addSubview(tableView)
        
        view.addSubview(tableControllers)
        
        tableControllers.delegate = self
        
        title = Preferences.financeViewControllerTitle
        
        delegateMethods()
        
        self.view.backgroundColor = Theme.primaryBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableControllers.anchor(top: view.topAnchor,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                height: Preferences.financeTableControllerHeight)
        
        tableControllers.frameChildren()
        
        tableView.anchor(top: tableControllers.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
        
    }
    
    internal func sortByChangeHighToLow(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.changeNumeric > $1.1.changeNumeric})
            
            self.tableView.reloadData()
            
        }
        
    }
    
    internal func sortByChangeLowToHigh(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.changeNumeric < $1.1.changeNumeric})
            
            self.tableView.reloadData()
            
        }
        
    }
    
    internal func sortByPriceHighToLow(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.currentPrice > $1.1.currentPrice})
            
            self.tableView.reloadData()
            
        }
        
    }
    
    internal func sortByPriceLowToHigh(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.currentPrice < $1.1.currentPrice})
            
            self.tableView.reloadData()
            
        }
        
    }
    
    internal func sortBySizeHighToLow(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.marketCap > $1.1.marketCap})
            
            self.tableView.reloadData()
            
        }
        
    }
    
    internal func sortBySizeLowToHigh(){
        
        DispatchQueue.main.async {
            
            self.financeResponseDict = self.financeResponseDict.sorted(by: {$0.1.marketCap < $1.1.marketCap})
            
            self.tableView.reloadData()
            
        }
        
    }
    
}


extension FinanceViewController: TestDel{
    
}
