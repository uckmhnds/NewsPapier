//
//  FinanceDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceDetailViewController: UIViewController {
    
    lazy var test = BezierView(frame: .zero)
    
    var data: [FinanceHistory] = [FinanceHistory]()
    
    var isLoading: Bool = true {
        didSet{
            self.test.setData(testFunc())
            self.test.drawBezierCurve()
        }
    }
    
    private func localJSON(){
        
        DispatchQueue.main.async {
            
            if let response = DecodeLocal.shared.fetch(fileName: "aapl_history") as FinanceHistoryResponse?
            {
                self.data = response.data
            }
//            self.testFunc()
            
            self.isLoading = false
            print("dsafsa")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        localJSON()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.dataSource = self

        view.addSubview(test)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        test.frame = view.bounds
    }
    
    internal func testFunc() -> [CGPoint]{
        
        let minDate = Date(timeIntervalSince1970: self.data[0].Date / 1000)
        let maxDate = Date(timeIntervalSince1970: self.data[self.data.count - 1].Date / 1000)
        
        let cal = Calendar(identifier: .iso8601)
        
        let daySpan = cal.numberOfDaysBetween(minDate, and: maxDate)
        
        let minX: CGFloat = 0
        let maxX: CGFloat = self.view.bounds.width
        
        let minClose = self.data.min {$0.Close < $1.Close}?.Close
        let maxClose = self.data.max {$0.Close < $1.Close}?.Close
        
        let minY: CGFloat = 200
        let maxY: CGFloat = 400
        
        var pts: [CGPoint] = [CGPoint]()
        
        for datum in data{
            
            let currentDate = Date(timeIntervalSince1970: datum.Date / 1000)
            
            let x: CGFloat = (maxX - minX) * cal.numberOfDaysBetween(minDate, and: currentDate) / daySpan
            
            let y: CGFloat = (datum.Close - minClose!) / (maxClose! - minClose!) * (maxY - minY) + minY
            
            let _pt = CGPoint(x: x, y: y)
            
            pts.append(_pt)
        }
        return pts
    }
    

}

extension FinanceDetailViewController: BezierViewDataSource{

    var bezierViewDataPoints: [CGPoint] {

        var _pts: [CGPoint] = [CGPoint]()
        
        if !self.isLoading{
            _pts = testFunc()
        }
        
        return _pts

    }
    
    func setBezPts() -> [CGPoint] {
        
        var _pts: [CGPoint] = [CGPoint]()
        
        if !self.isLoading{
            _pts = testFunc()
        }
        
        return _pts
    }

}

extension Calendar{
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Double {
        
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return Double(numberOfDays.day!)
    }
    
}
