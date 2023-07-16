//
//  ContentViewVM.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import Foundation
import SwiftUI

@MainActor
class ContentViewVM: ObservableObject {
    
    @Published var users: [User] = []
    @Published var posts: [Post] = []
    @Published var comments: [Comment] = []
    
    @Published var userSelection = "User"
    @Published var postSelection = "Posts"
    @Published var commentSelection = "Comments"
    @Published var userIsExpanded = false
    @Published var postIsExpanded = false
    @Published var commentIsExpanded = false
    @Published var commentDetailIsExpanded = false
    @Published var disableDisclosureGroup = false
    
    @Published var alertItem: AlertItem?
    
    let usersEndpoint = "https://jsonplaceholder.typicode.com/users"
    let postsEndpoint = "https://jsonplaceholder.typicode.com/posts"
    let commentsEndpoint = "https://jsonplaceholder.typicode.com/comments"
    
    func fetchAllData() async {
        
        do {
            guard let usersURL = URL(string: usersEndpoint),
                  let postsURL = URL(string: postsEndpoint),
                  let commentsURL = URL(string: commentsEndpoint) else  {
                throw RTError.invalidURL
            }
            
            users = try await NetworkManager.shared.fetchData(for: [User.self], from: usersURL)
            posts = try await NetworkManager.shared.fetchData(for: [Post.self], from: postsURL)
            comments = try await NetworkManager.shared.fetchData(for: [Comment.self], from: commentsURL)
            
        } catch RTError.invalidURL {
            print("Invalid URL")
            alertItem = AlertContext.invalidURL
            
        } catch RTError.invalidResponse {
            print("Invalid response")
            alertItem = AlertContext.invalidResponse
            
        } catch RTError.invalidData {
            print("Invalid data")
            alertItem = AlertContext.invalidData
            
        } catch {
            alertItem = AlertContext.unableToComplete
            print("Unexpected error")
        }
    }
}
