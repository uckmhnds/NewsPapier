//
//  FinanceDetailViewController.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/19/23.
//

import UIKit

public enum HistoryPeriod: String, CaseIterable{
    
    case _1d
    case _5d
    case _1mo
    case _3mo
    case _6mo
    case _1y
    case _5y
    case _max
    
}

class FinanceDetailViewController: UIViewController {
    
    private var increasing: Bool?
    
    private var data: [FinanceHistory] = [FinanceHistory]()
    
    private var tintColor: UIColor? {
        if let increasing = self.increasing
        {
            return increasing ? .systemGreen : .systemRed
        }
        return nil
    }
    
    private var chevronImage: UIImage? {
        if let increasing = self.increasing,
            let imageUp = UIImage(systemName: "chevron.up"),
            let imageDown = UIImage(systemName: "chevron.down")
        {
            return increasing ? imageUp : imageDown
        }
        return nil
    }
    
    private lazy var priceTitle = UILabel(autoLayout: false,
                                          font: Theme.h1Title,
                                          color: Theme.primaryText,
                                          text: "$39,132.89",
                                          textAlignment: .center)
    
    private lazy var chevronView = UIImageView(contentMode: .scaleAspectFill,
                                               autoLayout: false,
                                               clipsToBounds: false)
    
    private lazy var changeTitle = UILabel(autoLayout: false,
                                           font: Theme.h3Accent,
                                           color: Theme.secondaryText,
                                           text: "3.5%",
                                           textAlignment: .center)
    
    private lazy var changeStackView = HStackView([chevronView, changeTitle],
                                                  autoLayout: false,
                                                  alignment: .center,
                                                  distribution: .fillProportionally,
                                                  spacing: Spacing.s1)

    private lazy var bezierView: BezierView = {
        
        let view = BezierView(frame: .zero)
        
        view.backgroundColor = Theme.primaryBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    var segmentIndex: Int = 0
    
    private lazy var periodSegments: UISegmentedControl = {
        
        let segmentControl  = UISegmentedControl(items: ["1d", "5d", "1mo", "3mo", "6mo", "1y", "5y", "max"])
        
        segmentControl.selectedSegmentIndex = segmentIndex
        segmentControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        return segmentControl
        
    }()
    
    @objc private func handleSegmentChange(){
        
        let period = HistoryPeriod.allCases[self.periodSegments.selectedSegmentIndex]
        
        switch period{
            
        case ._1d:
            print("_1d")
        case ._5d:
            print("_5d")
        case ._1mo:
            print("_1mo")
        case ._3mo:
            print("_3mo")
        case ._6mo:
            print("_6mo")
        case ._1y:
            print("_1y")
        case ._5y:
            print("_5y")
        case ._max:
            print("_max")
        }
        
    }
    
    lazy var stack = VStackView([priceTitle, changeStackView, bezierView, periodSegments], autoLayout: false, alignment: .center, distribution: .fillProportionally, spacing: Spacing.s1)
    
    var isLoading: Bool = true {
        
        didSet{
            
            if !self.isLoading{
                
                let points = self.setBezierPoints()
                if let points = points{
                    self.bezierView.setData(points)
                    self.bezierView.drawBezierCurve()
                }
                
            }
            
        }
        
    }
    
    private func applyConstraints(){
        
        bezierView.anchor(padding: UIEdgeInsets(top: Inset.zero,
                                                left: Inset.i1,
                                                bottom: Inset.zero,
                                                right: Inset.i1),
                          width: view.frame.width)
        
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     leading: view.leadingAnchor,
                     bottom: view.bottomAnchor,
                     trailing: view.trailingAnchor,
                     padding: UIEdgeInsets(top: Inset.zero,
                                           left: Inset.zero,
                                           bottom: Inset.i8,
                                           right: Inset.zero))
        
    }
    
    private func setCurveApparence(){
        
        if let chevronImage = self.chevronImage{
            
            self.chevronView.image = chevronImage
            
        }
        
        if let tintColor = self.tintColor{
            
            self.chevronView.tintColor = tintColor
            self.bezierView.setLineColor(tintColor)
            
        }
        
    }
    
    private func localJSON(){
        
        DispatchQueue.main.async {
            
            if let response = DecodeLocal.shared.fetch(fileName: "aapl_history") as FinanceHistoryResponse?
            {
                self.data = response.data
            }
            
            self.isLoading = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        localJSON()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AAPL"
        
        increasing = true
        
        view.addSubview(stack)
        
        applyConstraints()
        
        setCurveApparence()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
    }
    
    internal func setBezierPoints() -> [CGPoint]? {
        
        let minX: CGFloat = self.bezierView.frame.minX
        let maxX: CGFloat = self.bezierView.frame.maxX
        
        let minY: CGFloat = self.bezierView.frame.minY + Padding.p5
        let maxY: CGFloat = self.bezierView.frame.maxY - Padding.p5
        
        let cal = Calendar(identifier: .iso8601)
        
        if let firstData = self.data.first,
            let lastData = self.data.last,
            let minClose = self.data.min(by: {$0.Close < $1.Close}),
            let maxClose = self.data.max(by: {$0.Close < $1.Close})
        {
            let minDate = Date(timeIntervalSince1970: firstData.Date / 1000)
            let maxDate = Date(timeIntervalSince1970: lastData.Date / 1000)
            
            let daySpan = cal.numberOfDaysBetween(minDate, and: maxDate)
            
            let minClose = minClose.Close
            let maxClose = maxClose.Close
            
            var pts: [CGPoint] = [CGPoint]()
            
            for datum in data{
                
                let currentDate = Date(timeIntervalSince1970: datum.Date / 1000)
                
                let x: CGFloat = (maxX - minX) * cal.numberOfDaysBetween(minDate, and: currentDate) / daySpan
                
                let y: CGFloat = (maxY - minY) - (datum.Close - minClose) / (maxClose - minClose) * (maxY - minY) + Padding.p5
                
                let _pt = CGPoint(x: x, y: y)
                
                pts.append(_pt)
            }
            
            return pts
            
        }
        
        return nil
        
    }
    
}

