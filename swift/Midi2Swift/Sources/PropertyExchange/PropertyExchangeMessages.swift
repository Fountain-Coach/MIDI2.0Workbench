import Foundation

// Generated from contract/midi2.json state machine names
public enum PropertyExchangeMessage: String, CaseIterable {
    case inquiryPropertyExchangeCapabilities
    case replyToPropertyExchangeCapabilities
    case inquiryGetPropertyData
    case replyToGetPropertyData
    case inquirySetPropertyData
    case replyToSetPropertyData
}
