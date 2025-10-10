//
//  PreviewUtils.swift
//  F1Hub
//
//  Created by Marcos Morales on 14/04/2025.
//

import Foundation

func isRunningInPreview() -> Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
