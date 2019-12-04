//
//  UpdateCellProtocol.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import Foundation
import UIKit

protocol JediTableCellDelegate : class {
    func toggleHasBeenRead(for View: JediDetailViewController)
}
