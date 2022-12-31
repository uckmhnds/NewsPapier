//
//  Async.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/31/22.
//

import Foundation

enum Async {
    
    static func parallel(callBacks: [(@escaping () -> Void) -> Void],
                         completion: @escaping () -> Void)
    {
        let dispatchGroup = DispatchGroup()
        
        callBacks.forEach { callBack in
            dispatchGroup.enter()
            callBack({
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
}
