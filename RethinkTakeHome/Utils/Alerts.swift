//
//  Alerts.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/15/23.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
  
  let id = UUID()
  let title: Text
  let message: Text
  let dismissButton: Alert.Button
}

struct AlertContext {
  //MARK: - Network Alerts
  static let invalidData = AlertItem(title: Text("Server Error"), message: Text("Invalid data"), dismissButton: .default(Text("Ok")))
  static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("Invalid response"), dismissButton: .default(Text("Ok")))
  static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("Invalid URL"), dismissButton: .default(Text("Ok")))
  static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Unexpected error"), dismissButton: .default(Text("Ok")))
}
