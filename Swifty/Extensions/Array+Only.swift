//
//  Array+Only.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/6/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
