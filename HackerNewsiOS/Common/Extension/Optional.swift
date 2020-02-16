//
//  Optional.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import Foundation

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self.or("")
    }
}
