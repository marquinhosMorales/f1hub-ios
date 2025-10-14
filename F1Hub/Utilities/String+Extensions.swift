//
//  String+Extensions.swift
//  F1Hub
//
//  Created by Marcos Morales on 09/10/2025.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = contains("/") ? "dd/MM/yyyy" : "yyyy-MM-dd"

        guard let date = formatter.date(from: self) else {
            return self
        }

        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
