//
//  ContainerViewController.swift
//  Expo1900
//
//  Created by kakao on 2023/01/13.
//

import UIKit

class ContainerViewController: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations ?? [.portrait, .landscape]
    }
}
