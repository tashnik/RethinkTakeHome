//
//  Post.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import Foundation


struct Post: Codable, Identifiable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
