//
//  Comment.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import Foundation


struct Comment: Codable, Identifiable {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
