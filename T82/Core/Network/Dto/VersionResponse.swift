import Foundation

struct VersionResponse: Codable, Hashable {
    let latestVersion: String
}

struct CheckVersion: Codable, Hashable {
    let appId: String
    let currentVersion: String
}
