import Foundation

public enum PropertyExchangeResource: String, CaseIterable {
    case ResourceList
    case schema
    case DeviceInfo
    case schema
    case ChannelList
    case schema
    case JSONSchema
    case schema
    case ModeList
    case schema
    case CurrentMode
    case schema
    case ProgramList
    case schema
    case ExternalSync
    case schema
    case LocalOn
    case schema
    case ChannelMode
    case schema
    case BasicChannelRx
    case schema
    case BasicChannelTx
    case schema
    case State
    case schema
    case StateList
    case schema
    case MaxSysex8Streams
    case schema
    case AllCtrlList
    case schema
    case ChCtrlList
    case schema
    case CtrlMapList
    case schema
}

public enum PropertyExchangeCatalog {
    public static let all: [String] = [
        "ResourceList",
        "schema",
        "DeviceInfo",
        "schema",
        "ChannelList",
        "schema",
        "JSONSchema",
        "schema",
        "ModeList",
        "schema",
        "CurrentMode",
        "schema",
        "ProgramList",
        "schema",
        "ExternalSync",
        "schema",
        "LocalOn",
        "schema",
        "ChannelMode",
        "schema",
        "BasicChannelRx",
        "schema",
        "BasicChannelTx",
        "schema",
        "State",
        "schema",
        "StateList",
        "schema",
        "MaxSysex8Streams",
        "schema",
        "AllCtrlList",
        "schema",
        "ChCtrlList",
        "schema",
        "CtrlMapList",
        "schema"
    ]
}
