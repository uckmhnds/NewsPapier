//
//  NewsViewController+Protocol.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/12/22.
//

import UIKit

protocol NewsViewControllerDelegate: AnyObject{
    
    func newsViewControllerDidTapCell(_ news: News)
    
}
