//
//  User.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import Foundation


struct User: Codable, Identifiable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
}
