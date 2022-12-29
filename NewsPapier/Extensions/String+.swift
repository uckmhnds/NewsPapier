//
//  String.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/25/22.
//

import Foundation


extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
