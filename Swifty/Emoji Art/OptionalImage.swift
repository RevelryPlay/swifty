//
//  OptionalImage.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/16/21.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if (uiImage != nil) {
                Image(uiImage: uiImage!)
            }
        }
    }
}
