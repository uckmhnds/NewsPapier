//
//  FinanceViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceViewController: UIViewController {
    
    private let tableView = FinanceTableView()
    
    // MARK: - Network
    
    private var financeResponseDict: [FinanceCase: Finance] = [:]
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
                    self.financeResponseDict[finance] = response.data
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

        view.addSubview(tableView)
        // Do any additional setup after loading the view.
        delegateMethods()
        
        loadLocalNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func getFinanceDict() -> [FinanceCase: Finance] {
        return self.financeResponseDict
    }
    
    func getFinanceDict(with financeCase: FinanceCase) -> Finance? {
        return self.financeResponseDict[financeCase]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}


extension FinanceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FinanceCase.size
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.identifier, for: indexPath) as? FinanceTableViewCell else { return UITableViewCell()}
        
        let _case = FinanceCase.allCases[indexPath.row]
        
        if let finance = self.getFinanceDict(with: _case){
            cell.setFinance(finance)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
