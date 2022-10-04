// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let category = ImageAsset(name: "Category")
  internal static let categoryRed = ImageAsset(name: "CategoryRed")
  internal static let group1 = ImageAsset(name: "Group-1")
  internal static let group3 = ImageAsset(name: "Group-3")
  internal static let logout = ImageAsset(name: "Logout")
  internal static let profile = ImageAsset(name: "Profile")
  internal static let aboutMore = ImageAsset(name: "about_more")
  internal static let aboutMore2 = ImageAsset(name: "about_more2")
  internal static let accessDenied = ImageAsset(name: "access_denied")
  internal static let accessUniversal = ImageAsset(name: "access_universal")
  internal static let backArrow = ImageAsset(name: "back_arrow")
  internal static let backArrowLast = ImageAsset(name: "back_arrow_last")
  internal static let basketball1 = ImageAsset(name: "basketball-1")
  internal static let callMore = ImageAsset(name: "call_more")
  internal static let clock = ImageAsset(name: "clock")
  internal static let clockCalendar = ImageAsset(name: "clock_calendar")
  internal static let concert = ImageAsset(name: "concert")
  internal static let contactus = ImageAsset(name: "contactus")
  internal static let darkModeLast = ImageAsset(name: "darkModeLast")
  internal static let eventLogo = ImageAsset(name: "event_logo")
  internal static let eventSearcherLogo = ImageAsset(name: "event_searcher_logo")
  internal static let family = ImageAsset(name: "family")
  internal static let family1 = ImageAsset(name: "family1")
  internal static let film = ImageAsset(name: "film")
  internal static let gradientBackground = ImageAsset(name: "gradient_background")
  internal static let gradientTest = ImageAsset(name: "gradient_test")
  internal static let heartMore = ImageAsset(name: "heart_more")
  internal static let helpDark = ImageAsset(name: "help_dark")
  internal static let homeFilled = ImageAsset(name: "home_filled")
  internal static let homeIcon183924 = ImageAsset(name: "home_icon_183924")
  internal static let i1 = ImageAsset(name: "i1")
  internal static let i2 = ImageAsset(name: "i2")
  internal static let i3 = ImageAsset(name: "i3")
  internal static let icBookmarkFilled = ImageAsset(name: "icBookmarkFilled")
  internal static let icStar = ImageAsset(name: "icStar")
  internal static let icBookmark = ImageAsset(name: "ic_bookmark")
  internal static let icBottomVector = ImageAsset(name: "ic_bottom_vector")
  internal static let icHome = ImageAsset(name: "ic_home")
  internal static let icHomeSelected = ImageAsset(name: "ic_home_selected")
  internal static let icLeft = ImageAsset(name: "ic_left")
  internal static let icPasswordInvisible = ImageAsset(name: "ic_password_invisible")
  internal static let icPasswordVisible = ImageAsset(name: "ic_password_visible")
  internal static let icProfile = ImageAsset(name: "ic_profile")
  internal static let icSearch = ImageAsset(name: "ic_search")
  internal static let icVektorMini = ImageAsset(name: "ic_vektor_mini")
  internal static let icWhiteBookmark = ImageAsset(name: "ic_whiteBookmark")
  internal static let icWhiteStar = ImageAsset(name: "ic_whiteStar")
  internal static let icons8Performance50 = ImageAsset(name: "icons8-performance-50")
  internal static let icons8PublicSpeaking64 = ImageAsset(name: "icons8-public-speaking-64")
  internal static let info = ImageAsset(name: "info")
  internal static let info1 = ImageAsset(name: "info_1")
  internal static let infoFilled = ImageAsset(name: "info_filled")
  internal static let langIcon = ImageAsset(name: "lang_icon")
  internal static let location = ImageAsset(name: "location")
  internal static let locationFilled = ImageAsset(name: "location_filled")
  internal static let locationFilled1 = ImageAsset(name: "location_filled1")
  internal static let locationFilled2 = ImageAsset(name: "location_filled2")
  internal static let locationPointer = ImageAsset(name: "location_pointer")
  internal static let logoutIcon = ImageAsset(name: "logout_icon")
  internal static let logoutIconBig = ImageAsset(name: "logout_icon_big")
  internal static let logoutMore = ImageAsset(name: "logout_more")
  internal static let loopImage = ImageAsset(name: "loopImage")
  internal static let mixed = ImageAsset(name: "mixed")
  internal static let music = ImageAsset(name: "music")
  internal static let nonticket = ImageAsset(name: "nonticket")
  internal static let nzmProfile = ImageAsset(name: "nzm_profile")
  internal static let personIcon = ImageAsset(name: "person_icon")
  internal static let phone = ImageAsset(name: "phone")
  internal static let phone1 = ImageAsset(name: "phone1")
  internal static let plus = ImageAsset(name: "plus")
  internal static let policy = ImageAsset(name: "policy")
  internal static let price = ImageAsset(name: "price")
  internal static let profile1 = ImageAsset(name: "profile-1")
  internal static let search = ImageAsset(name: "search")
  internal static let searchFilled = ImageAsset(name: "search_filled")
  internal static let searchFirst = ImageAsset(name: "search_first")
  internal static let searchSelected = ImageAsset(name: "search_selected")
  internal static let settingMenu = ImageAsset(name: "setting_menu")
  internal static let shareIcon = ImageAsset(name: "share_icon")
  internal static let starOutlined = ImageAsset(name: "star_outlined")
  internal static let starOutlinedFilled = ImageAsset(name: "star_outlined_filled")
  internal static let stopHand = ImageAsset(name: "stop_hand")
  internal static let test1 = ImageAsset(name: "test1")
  internal static let test2 = ImageAsset(name: "test2")
  internal static let test3 = ImageAsset(name: "test3")
  internal static let test4 = ImageAsset(name: "test4")
  internal static let test5 = ImageAsset(name: "test5")
  internal static let test6 = ImageAsset(name: "test6")
  internal static let test7 = ImageAsset(name: "test7")
  internal static let test8 = ImageAsset(name: "test8")
  internal static let test9 = ImageAsset(name: "test9")
  internal static let theatre = ImageAsset(name: "theatre")
  internal static let tourism = ImageAsset(name: "tourism")
  internal static let upsell = ImageAsset(name: "upsell")
  internal static let userEmpty = ImageAsset(name: "user_empty")
  internal static let userFilled = ImageAsset(name: "user_filled")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
