// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Done
  internal static let done = L10n.tr("Localizable", "DONE")
  /// Error
  internal static let error = L10n.tr("Localizable", "ERROR")
  /// Now Playing
  internal static let nowPlaying = L10n.tr("Localizable", "NOW_PLAYING")
  /// Top Rated
  internal static let topRated = L10n.tr("Localizable", "TOP_RATED")
  /// vote
  internal static let vote = L10n.tr("Localizable", "VOTE")
  /// votes
  internal static let votes = L10n.tr("Localizable", "VOTES")
  /// WizeMovie
  internal static let wizemovie = L10n.tr("Localizable", "WIZEMOVIE")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
