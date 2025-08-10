import Foundation

public enum PropertyExchangeResource: String, CaseIterable {
    case ResourceList
    case DeviceInfo
    case ChannelList
    case JSONSchema
    case ModeList
    case CurrentMode
    case ProgramList
    case ExternalSync
    case LocalOn
    case ChannelMode
    case BasicChannelRx
    case BasicChannelTx
    case State
    case StateList
    case MaxSysex8Streams
    case AllCtrlList
    case ChCtrlList
    case CtrlMapList
}

public enum PropertyExchangeCatalog {
    public static let all: [String] = [
        "ResourceList",
        "DeviceInfo",
        "ChannelList",
        "JSONSchema",
        "ModeList",
        "CurrentMode",
        "ProgramList",
        "ExternalSync",
        "LocalOn",
        "ChannelMode",
        "BasicChannelRx",
        "BasicChannelTx",
        "State",
        "StateList",
        "MaxSysex8Streams",
        "AllCtrlList",
        "ChCtrlList",
        "CtrlMapList"
    ]
}
