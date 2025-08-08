//
//  MemberPageViewModel.swift
//  timerCountdown
//
//  Created by Biene Bryle Sanico on 8/8/25.
//

import Foundation
import Combine

class MemberPageViewModel: ObservableObject {
    @Published var memberName: String = ""
    @Published var memberAge: Int = 0
}
