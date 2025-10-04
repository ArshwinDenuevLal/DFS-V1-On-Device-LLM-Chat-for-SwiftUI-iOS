//
//  Item.swift
//  DFSVOneChat
//
//  Created by Admin on 13/09/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
