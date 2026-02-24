
struct MessageAnalyzer {
    
    static func analyze(text: String) -> AnalysisResult {
        
        let text = text.lowercased()
        var reasons: [String] = []
        
        //  Request for sensitive information
        let sensitivePatterns = [
            
            //otp words
            "otp", "one time password", "verification code",
            "security code", "confirm code", "sms code",
            
//password word
            "password", "passcode", "login details",
            
            //Financial data
            "credit card", "card number", "cvv", "expiry date",
            "bank account", "iban", "bank details",
            
            //Personal ID
            "national id", "id number", "identity number",
            "passport number", "iqama", "residency number",
            
            // Verify statements
            "verify your identity", "confirm your account",
            "update your details", "submit your information"
        ]
        
        if sensitivePatterns.contains(where: { text.contains($0) }) {
            reasons.append("Requests sensitive information")
            return AnalysisResult(type: .scam, reasons: reasons)
        }
        
        //  Seductive words
        let baitPatterns = [
            "free", "won", "winner", "prize",
            "reward", "bonus", "cashback",
            "lottery", "jackpot", "giveaway",
            "claim your reward", "exclusive offer",
            "special deal", "promotion"
        ]
        
        // Words of pressure and urgency
        let urgencyPatterns = [
            "urgent", "immediately", "right now",
            "act now", "hurry", "final notice",
            "last chance", "limited time",
            "expires today", "within 24 hours",
            "account suspended", "action required",
            "failure to respond", "legal action"
        ]
        
        if baitPatterns.contains(where: { text.contains($0) }) {
            reasons.append("Contains reward or bait language")
        }
        
        if urgencyPatterns.contains(where: { text.contains($0) }) {
            reasons.append("Creates urgency or pressure")
        }
        
        if !reasons.isEmpty {
            return AnalysisResult(type: .suspicious, reasons: reasons)
        }
        
        return AnalysisResult(type: .safe, reasons: [])
    }
}
