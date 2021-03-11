//
//  LayoutContext.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2018-06-07.
//  Copyright © 2018 lkzhao. All rights reserved.
//

import UIKit

public protocol LayoutContext {
  var collectionSize: CGSize { get }
  var numberOfItems: Int { get }
  func identifier(at: Int) -> AnyHashable
  func size(at index: Int, collectionSize: CGSize) -> CGSize
}
