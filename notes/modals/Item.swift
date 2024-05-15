//
//  Item.swift
//  notes
//
//  Created by Nick Spaargaren on 15/05/2024.
//

import Foundation
import SwiftData

@Model
final class Time {
    var gamertag: String
    var circuit: String
    var time: String
    
    init(gamertag: String, circuit: String, time: String) {
        self.gamertag = gamertag
        self.circuit = circuit
        self.time = time
    }
}
