//
//  analyzeMessage.swift
//  SafeTap
//
//  Created by Wed Ahmed Alasiri on 04/08/1447 AH.
//

func analyzeMessage(_ text: String) -> ResultType {
    let lowercased = text.lowercased()
    var score = 0

    let scamKeywords = [
        "http", "www",
        "verify", "otp", "password",
        "update", "confirm",
        "urgent", "immediately", "within",
        "won", "prize", "congratulations",
        "bank", "account",
        "أبشر", "stc", "حسابك", "سدد", "إيقاف"
    ]

    for keyword in scamKeywords {
        if lowercased.contains(keyword) {
            score += 1
        }
    }

    if score == 0 {
        return .safe
    } else if score <= 2 {
        return .suspicious
    } else {
        return .scam
    }
}
