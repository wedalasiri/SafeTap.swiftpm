//
//  Logic.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 07/09/1447 AH.
//

enum ResultType {
    case safe
    case suspicious
    case scam
}
enum MessageType {
    case safe
    case suspicious
    case scam
}

struct AnalysisResult {
    let type: MessageType
    let reasons: [String]
}
