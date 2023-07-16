//
//  ContentView.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expandedStates: [String: Bool] = [:]
    
    @State private var assignedPosts: [Post] = []
    @State private var assignedComments: [Comment] = []
    
    @StateObject var contentViewVM = ContentViewVM()
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
            
            VStack() {
               
                Header(contentViewVM: contentViewVM)
                
                ScrollView(showsIndicators: false) {
                    DisclosureGroup(contentViewVM.userSelection, isExpanded: $contentViewVM.userIsExpanded) {
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(contentViewVM.users) { user in
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(user.name == contentViewVM.userSelection ? Color.mint : Color.white)
                                            .font(.title3)
                                            .padding(.leading, 5)
                                        
                                        Text(user.name)
                                            .font(.title3)
                                            .padding(.all, 10)
                                    }
                                    .onTapGesture {
                                        contentViewVM.userSelection = user.name
                                        contentViewVM.postSelection = "Posts"
                                        contentViewVM.commentSelection = "Comments"
                                        assignedComments = []
                                        
                                        withAnimation {
                                            assignedPosts = contentViewVM.posts.filter { $0.userId == user.id }
                                            
                                            contentViewVM.userIsExpanded.toggle()
                                        }
                                    }
                                    .padding(.all, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.white, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    
                    DisclosureGroup(contentViewVM.postSelection, isExpanded: $contentViewVM.postIsExpanded) {
                        ScrollView {
                            VStack {
                                ForEach(assignedPosts) { post in
                                    Text(post.body)
                                        .padding(.all, 10)
                                        .onTapGesture {
                                            contentViewVM.postSelection = post.title
                                            contentViewVM.commentSelection = "Comments"
                                            assignedComments = []
                                            
                                            withAnimation {
                                                assignedComments = contentViewVM.comments.filter { $0.postId == post.id }
                                                contentViewVM.postIsExpanded.toggle()
                                            }
                                        }
                                    
                                    RTDivider()
                                }
                            }
                        }
                    }
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(radius: 8)
                    .onChange(of: contentViewVM.postIsExpanded) { _ in
                        if assignedPosts.count == 0 {
                            contentViewVM.alertItem = AlertItem(title: Text("Rethink!"), message: Text("Please choose a user first"), dismissButton: .default(Text("Ok")))
                        }
                    }
                    
                    DisclosureGroup(contentViewVM.commentSelection, isExpanded: $contentViewVM.commentIsExpanded) {
                        ForEach(assignedComments) { comment in
                            VStack(spacing: 5) {
                                
                                DisclosureGroup(comment.name, isExpanded: Binding(
                                    get: { expandedStates[comment.name] ?? false },
                                    set: { newValue in
                                        expandedStates[comment.name] = newValue
                                    })) {
                                        
                                        Text(comment.email)
                                            .bold()
                                            .padding(10)
                                        Text(comment.body)
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            contentViewVM.commentSelection = comment.name
                                            expandedStates[comment.name]?.toggle()
                                        }
                                    }
                                
                                RTDivider()
                            }
                            .padding(10)
                        }
                    }
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(radius: 8)
                    .onChange(of: contentViewVM.commentIsExpanded) { _ in
                        if assignedComments.count == 0 {
                            contentViewVM.alertItem = AlertItem(title: Text("Rethink!"), message: Text("Please choose a post first"), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .task {
                await contentViewVM.fetchAllData()
            }
        }
        .alert(item: $contentViewVM.alertItem) { alertItem in
          Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//MARK: - Views
struct RTDivider: View {
    
    let color: Color = .white
    let width: CGFloat = 2
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct Header: View {
    
    let contentViewVM: ContentViewVM
    
    var body: some View {
        HStack {
            VStack {
                Text("David Potashnik")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding([.leading, .top], 10)
                
                Text("Rethink Interview")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 10)
            }
            
            Button {
                contentViewVM.alertItem = AlertItem(title: Text("Rethink!"), message: Text("Users: \(contentViewVM.users.count) \n Posts: \(contentViewVM.posts.count) \n Comments: \(contentViewVM.comments.count)"), dismissButton: .default(Text("Ok")))
                
            } label: {
                Text("Count")
            }
            .shadow(radius: 8)
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .background(Color.mint)
        .cornerRadius(8)
        .padding(10)
    }
}
