//
//  Todo.swift
//  FirebaseExample
//
//  Created by 신승아 on 2022/10/13.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var importance: Int
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    @Persisted var detail: List<detailTodo>
    @Persisted var memo: Memo? // EmbededObject 는 항상 Optional
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance = importance
    }
}

class detailTodo: Object {
    @Persisted var detailTitle: String
    @Persisted var favorite: Bool
    @Persisted var deadline: Date
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    
    convenience init(detailTitle: String, favorite: Bool) {
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
    }
}

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
    
    convenience init(content: String, date: Date) {
        self.init()
        self.content = content
        self.date = date
    }
}
