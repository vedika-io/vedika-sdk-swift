// Where the packaged offline Vastu runtime lives, for both ways of installing the SDK.
//
// SwiftPM generates `Bundle.module` for a package that declares resources, and only for SwiftPM: a CocoaPods
// build has no such symbol, so every use of it would stop the pod from compiling. Every lookup of the
// packaged runtime goes through here instead. A package build still reads `Bundle.module`; a pod build reads
// the resource bundle that VedikaSDK.podspec names `VedikaSDKResources`, which sits inside the pod's framework
// (use_frameworks!) or in the app bundle (static libraries).

import Foundation

#if !SWIFT_PACKAGE
private final class VedikaBundleToken {}
#endif

extension Bundle {
    /// The bundle that holds this SDK's own resources.
    static var vedikaResources: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let host = Bundle(for: VedikaBundleToken.self)
        for candidate in [host, Bundle.main] {
            if let url = candidate.url(forResource: "VedikaSDKResources", withExtension: "bundle"),
               let bundle = Bundle(url: url) {
                return bundle
            }
        }
        return host
        #endif
    }

    /// The packaged Vastu runtime's `index.html`, in its `VastuRuntime` folder, or at the top of the bundle when a
    /// resource bundle was flattened.
    static var vedikaRuntimeIndex: URL? {
        vedikaResources.url(forResource: "index", withExtension: "html", subdirectory: "VastuRuntime")
            ?? vedikaResources.url(forResource: "index", withExtension: "html")
    }
}
