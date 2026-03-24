import Foundation
import SwiftUI

struct SharePhoto: Transferable {
    let image: Image
    let caption: String
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \SharePhoto.image)
    }
}
