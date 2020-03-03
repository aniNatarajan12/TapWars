//
//  TouchDownGestureRecognizer.swift
//  TapWars
//
//  Created by Anirudh Natarajan on 3/1/20.
//  Copyright © 2020 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit.UIGestureRecognizerSubclass

class TouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
}
