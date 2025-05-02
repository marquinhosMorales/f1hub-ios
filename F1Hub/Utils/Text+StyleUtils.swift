//
//  Text+StyleUtils.swift
//  F1Hub
//
//  Created by Marcos Morales on 15/04/2025.
//

import SwiftUI

extension Text {
    func regularTextStyle(_ size: CGFloat) -> Text {
        return self.font(.custom("Formula1-Display-Regular", size: size))
    }
    
    func boldTextStyle(_ size: CGFloat) -> Text {
        return self.font(.custom("Formula1-Display-Bold", size: size))
    }
    
    func wideTextStyle(_ size: CGFloat) -> Text {
        return self.font(.custom("Formula1-Display-Wide", size: size))
    }
}
