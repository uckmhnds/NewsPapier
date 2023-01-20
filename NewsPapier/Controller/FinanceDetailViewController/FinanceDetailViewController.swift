//
//  FinanceDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

class FinanceDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        setColors()
//
//        let test = BezierView(frame: categoryImageView.bounds)
//        test.dataSource = self
//
//        categoryImageView.addSubview(test)
//        test.drawBezierCurve()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pts(_ x: Double) -> CGPoint {
        return CGPoint(x: x, y: -2.5 * x + 80)
    }

}

extension FinanceDetailViewController: BezierViewDataSource{
    
    var bezierViewDataPoints: [CGPoint] {
        
        var _pts: [CGPoint] = [CGPoint]()
        
        return _pts
        
    }
    
}
