//
//  AssignmentsApp.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/14.
//

import SwiftUI

@main
struct AssignmentsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: ViewModel())
        }
    }
}
