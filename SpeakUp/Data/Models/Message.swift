//
//  Message.swift
//  SpeakUp
//
//  Created by SUPER CHARGE on 15/09/26.
//
import Foundation

struct Message: Identifiable, Hashable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date = Date()
}

