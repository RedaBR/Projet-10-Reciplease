//
//  PropertiesRecipService.swift
//  Reciplease
//
//  Created by Reda on 06/05/2022.
//

import Foundation
class PropertiesRecipService {
    static let shared = PropertiesRecipService()
    var listRecip: [PropertiesReciplease] = []

    func clearList () {
        listRecip.removeAll()
    }
    func addList (list: PropertiesReciplease) {
        listRecip.append(list)
    }
}
