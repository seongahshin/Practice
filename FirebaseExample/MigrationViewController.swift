//
//  MigrationViewController.swift
//  FirebaseExample
//
//  Created by 신승아 on 2022/10/13.
//

import UIKit

import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        // 1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL!)")
        
        // 2. SchemaVersion
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("SchemaVersion: \(version)")
        } catch {
            
        }
        
        // 3. Sample Data
//        for i in 1...100 {
//            let task = Todo(title: "고래밥의 할일 \(i)", importance: Int.random(in: 1...5))
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
//        for i in 1...10 {
//            let task = detailTodo(detailTitle: "양파 \(i)개 사기", favorite: true)
//
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
        // 특정 todo 테이블에 detailtodo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 5'").first else { return }
//        let detail = detailTodo(detailTitle: "프랭크 \(Int.random(in: 1...5))개 먹기", favorite: false)
//
//        for _ in 1...10 {
//            try! localRealm.write {
//                task.detail.append(detail)
//            }
//        }
        
        // 특정 todo 테이블 삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 5'").first else { return }
//        try! localRealm.write {
//            localRealm.delete(task.detail)
//            localRealm.delete(task)
//        }
        
        // 특정 todo 메모 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 9'").first else { return }
        let memo = Memo()
        memo.content = "이렇게 메모 내용을 추가해봅니다"
        memo.date = Date()
        
        try! localRealm.write {
            task.memo = memo
        }
        
    }
    
    
}
