//
//  Preferences.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

#warning("App preferences for Light / Dark mode")
#warning("App preferences for Language / Region etc.")

protocol AppPreferences{
    var region: [String: CountryCase] { get set }
}

public struct UserPreferences{
    
    static let defaults = UserDefaults.standard
    
//    var region: [String: CountryCase] {
//        get {
//            guard let _region = UserDefaults.standard.object(forKey: "Region") as? CountryCase else {
//                return ["Region": .us]
//            }
//            return ["Region": _region]
//        }
//        set {
//
//        }
//    }
    
}

struct Padding{
    
    static let zero: CGFloat = 0
    
    static let p0: CGFloat = 5
    static let p1: CGFloat = 7
    static let p2: CGFloat = 10
    static let p3: CGFloat = 13
    static let p4: CGFloat = 18
    static let p5: CGFloat = 24
    
}

struct Radius{
    
    static let zero: CGFloat = 0
    
    static let r0: CGFloat = 5
    static let r1: CGFloat = 7
    static let r2: CGFloat = 10
    static let r3: CGFloat = 13
    static let r4: CGFloat = 18
    static let r5: CGFloat = 24
    
}

struct Fraction{
    
    static let zero: CGFloat = 0
    
    static let f0: CGFloat = 0.08
    static let f1: CGFloat = 0.14
    static let f2: CGFloat = 0.28
    static let f3: CGFloat = 0.4
    static let f4: CGFloat = 0.6
    static let f5: CGFloat = 0.8
    
    static let quarter: CGFloat = 0.25
    static let third: CGFloat = 0.333
    static let half: CGFloat = 0.5
    static let one: CGFloat = 1.0
    
}

struct Inset{
    
    static let zero: CGFloat = 0
    
    static let i0: CGFloat = 5
    static let i1: CGFloat = 10
    static let i2: CGFloat = 15
    static let i3: CGFloat = 20
    static let i4: CGFloat = 25
    static let i5: CGFloat = 40
    
}

struct Size{
    
    static let zero: CGFloat = 0
    
    static let s0: CGFloat = 10
    static let s1: CGFloat = 20
    static let s2: CGFloat = 40
    static let s3: CGFloat = 60
    static let s4: CGFloat = 80
    static let s5: CGFloat = 100
    
    
}

struct Alpha{
    
    static let zero: CGFloat = 0
    
    static let a0: CGFloat = 0.2
    static let a1: CGFloat = 0.4
    static let a2: CGFloat = 0.5
    static let a3: CGFloat = 0.6
    static let a4: CGFloat = 0.8
    static let a5: CGFloat = 1.0
    
}

struct Duration{
    
    static let zero: CGFloat = 0
    
    static let d0: TimeInterval = 0.1
    static let d1: TimeInterval = 0.2
    static let d2: TimeInterval = 0.25
    static let d3: TimeInterval = 0.4
    static let d4: TimeInterval = 0.5
    static let d5: TimeInterval = 0.8
    
}

struct Time{
    
    static let zero: CGFloat = 0
    
    static let t0: Double = 0.2
    static let t1: Double = 0.4
    static let t2: Double = 0.8
    static let t3: Double = 1.2
    static let t4: Double = 1.5
    static let t5: Double = 2.0
    
}

struct Lipsum{
    
    static let zero: String = ""
    
    static let l0: String = "Lorem"
    static let l1: String = "Lorem ipsum"
    static let l2: String = "Lorem ipsum dolor sit amet"
    static let l3: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    static let l4: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    static let l5: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    static let l6: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
    static let l7: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    static let l8: String = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    
}
