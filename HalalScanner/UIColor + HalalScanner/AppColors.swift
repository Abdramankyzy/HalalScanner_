import UIKit

extension UIColor {

    
    // Dastarkhan AI brand orange (primary)
    static let appGreen = UIColor(red: 0.89, green: 0.49, blue: 0.13, alpha: 1) // #E37D20 warm orange
    static let appRed   = UIColor(red: 205/255, green: 35/255, blue: 35/255, alpha: 1)

    // Cream/warm background inspired by Dastarkhan AI slidedoc
    static let appBackground = UIColor(red: 0.96, green: 0.95, blue: 0.92, alpha: 1) // warm cream
    static let appSurface    = UIColor(red: 1.0, green: 0.99, blue: 0.97, alpha: 1)  // off-white
    static let appDarkCard   = UIColor(red: 0.13, green: 0.15, blue: 0.20, alpha: 1) // deep navy

    static let appCardGreen = UIColor(red: 0.95, green: 0.88, blue: 0.75, alpha: 1) // warm amber tint
    static let appCardRed   = UIColor(red: 0.99, green: 0.92, blue: 0.92, alpha: 1)

    static let appHalalText    = UIColor(red: 0.11, green: 0.62, blue: 0.46, alpha: 1) // verified green
    static let appHaramText    = UIColor.systemRed

    static let appHalalBadge    = UIColor(red: 0.11, green: 0.62, blue: 0.46, alpha: 0.3)
    static let appHaramBadge    = UIColor.systemRed.withAlphaComponent(0.3)
    static let appDoubtfulBadge = UIColor(red: 0.89, green: 0.49, blue: 0.13, alpha: 0.3)
    static let appOrangeSubtle  = UIColor(red: 0.89, green: 0.49, blue: 0.13, alpha: 0.2)

    static let appHalalStatBg    = UIColor(red: 0.11, green: 0.62, blue: 0.46, alpha: 0.1)
    static let appHaramStatBg    = UIColor.systemRed.withAlphaComponent(0.1)
    static let appHalalStatLabel = UIColor(red: 0.11, green: 0.62, blue: 0.46, alpha: 0.7)
    static let appHaramStatLabel = UIColor.systemRed.withAlphaComponent(0.7)

    static let appScannerStatus = UIColor.gray.withAlphaComponent(0.7)
    static let appOverlayLabel  = UIColor.black.withAlphaComponent(0.7)
    static let appOverlayMask   = UIColor.black.withAlphaComponent(0.55)

    static let appHeaderOverlay   = UIColor.white.withAlphaComponent(0.25)
    static let appHeaderSubtext   = UIColor.white.withAlphaComponent(0.8)
    static let appHeaderBadge     = UIColor.white.withAlphaComponent(0.2)
    static let appHeaderMutedText = UIColor.white.withAlphaComponent(0.7)

    static var appGreenSubtle: UIColor { appGreen.withAlphaComponent(0.15) }
    static var appGreenMuted:  UIColor { appGreen.withAlphaComponent(0.7) }
    static let appBlueSubtle   = UIColor.systemBlue.withAlphaComponent(0.15)
    static let appBlueFaint    = UIColor.systemBlue.withAlphaComponent(0.08)
    static let appBlueMuted    = UIColor.systemBlue.withAlphaComponent(0.7)
    static let appRedSubtle    = UIColor.systemRed.withAlphaComponent(0.15)

    static let appLogoutBackground = UIColor.systemRed.withAlphaComponent(0.1)

    static var appScannerActive: UIColor { appGreen.withAlphaComponent(0.85) }
}
