//
//  Model.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 3/11/23.
//

import Foundation
import SwiftUI

struct APIInfo: Codable{
    let date: Date
    let explanation: String
    let hdurl: URL
    let title: String
}
