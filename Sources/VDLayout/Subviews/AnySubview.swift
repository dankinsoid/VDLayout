import Foundation

public struct AnySubview: Subview {
	
	public let subviewInstaller: SubviewInstaller
	
	public init(_ subview: any Subview) {
		subviewInstaller = subview.subviewInstaller
	}
}
