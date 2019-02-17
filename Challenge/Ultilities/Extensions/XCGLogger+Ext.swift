//
//  XCGLogger+Ext.swift
//  iAntiTheft
//
//  Created by Nah on 3/27/18.
//  Copyright © 2018 Nah. All rights reserved.
//

import Foundation
import XCGLogger

extension XCGLogger {
    static func customize() -> XCGLogger? {
        // Create log folder if need
        try? FileManager.default.createDirectory(at: LogConfig.directoryUrl, withIntermediateDirectories: true, attributes: nil)

        // Datetime
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        timeFormatter.locale = Locale.current

        // Emojis
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "⚛", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔷", to: .debug)
        emojiLogFormatter.apply(prefix: "♻️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "🚫", to: .error)
        emojiLogFormatter.apply(prefix: "🆘", to: .severe)

        // Create a file log destination
        let fileDestination = FileDestination(writeToFile: LogConfig.fileUrl.path, identifier: "advancedLogger.fileDestination")
        // Optionally set some configuration options
        fileDestination.outputLevel = .verbose
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = true
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true
        // Process this destination in the background
        fileDestination.logQueue = XCGLogger.logQueue
        // Add format
        fileDestination.formatters = [emojiLogFormatter]

        // Create main log
        #if DEBUG
            let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: true)
        #else
            let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
        #endif

        // Clean up old cache
        log.cleanUpCache()

        // Add file destination to write log into file
        log.add(destination: fileDestination)

        // Format datetime & levels
        log.dateFormatter = timeFormatter
        log.formatters = [emojiLogFormatter]

        log.setup(level: .verbose,
                  showLogIdentifier: false,
                  showFunctionName: true,
                  showThreadName: true,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  writeToFile: nil,
                  fileLevel: .debug)

        return log
    }

    private func cleanUpCache() {
        let fileURLs = validFileURLs(parentURL: LogConfig.directoryUrl)

        let attributesList = fileURLs
            .compactMap({ url -> [AttributeKey: Any]? in
                guard let attr = attributes(path: url.path) else { return nil }
                return [.url: url,
                        .date: attr[.modificationDate] as Any,
                        .size: attr[.size] as Any]
            }).sorted(by: ({ ($0[.date] as! Date) > ($1[.date] as! Date) }))

        var fileSize = 0
        var fileCount = 0

        var removeURLs: [URL] = []
        for attr in attributesList {
            // Remove by size
            fileSize += attr[.size] as! Int
            if fileSize > LogConfig.sizesLimit {
                removeURLs.append(attr[.url] as! URL)
                continue
            }
            // Remove by count
            fileCount += 1
            if fileCount > LogConfig.filesLimit {
                removeURLs.append(attr[.url] as! URL)
                continue
            }
        }

        removeURLs.forEach({ try? FileManager.default.removeItem(at: $0) })
    }
}

private extension XCGLogger {
    enum AttributeKey {
        case url, date, size
    }

    func attributes(path: String) -> [FileAttributeKey: Any]? {
        return try? FileManager.default.attributesOfItem(atPath: path)
    }

    func validFileURLs(parentURL: URL) -> [URL] {
        guard let allURLs = try? FileManager.default.contentsOfDirectory(at: parentURL, includingPropertiesForKeys: nil, options: .skipsPackageDescendants) else {
            return []
        }

        var validURLs: [URL] = []
        for url in allURLs {
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) {
                if !isDir.boolValue, !url.path.hasPrefix(".") {
                    validURLs.append(url)
                }
            }
        }
        return validURLs
    }
}
