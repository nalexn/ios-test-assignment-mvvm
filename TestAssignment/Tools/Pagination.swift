//
//  Pagination.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

struct Pagination {
    let offset: Int
    let pageSize: Int

    private init(offset: Int = 0, pageSize: Int = 30) {
        self.offset = offset
        self.pageSize = pageSize
    }

    static var firstPage: Pagination {
        return Pagination()
    }

    var nextPage: Pagination {
        return Pagination(offset: offset + pageSize, pageSize: pageSize)
    }
}
