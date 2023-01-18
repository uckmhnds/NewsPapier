//
//  Extensions.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/11/22.
//

import UIKit

enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}

struct CompositionalLayout {
    
    static func createItem(width: NSCollectionLayoutDimension,
                           height: NSCollectionLayoutDimension,
                           spacing: CGFloat
    ) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                             heightDimension: height))
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        return item
    }
    
    static func createGroup(alignment: CompositionalGroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            items: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                       heightDimension: height),
                                                    subitems: items)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                         heightDimension: height),
                                                      subitems: items)
        }
    }
    
    static func createGroup(alignment: CompositionalGroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            item: NSCollectionLayoutItem,
                            count: Int
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            if #available(iOS 16.0, *) {
                return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                           heightDimension: height),
                                                        repeatingSubitem: item,
                                                        count: count)
            } else {
                // Fallback on earlier versions
                return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                             heightDimension: height), subitems: [item])
            }
        case .horizontal:
            if #available(iOS 16.0, *) {
                return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                             heightDimension: height),
                                                          repeatingSubitem: item,
                                                          count: count)
            } else {
                // Fallback on earlier versions
                return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                             heightDimension: height), subitems: [item])
            }
        }
    }
}
