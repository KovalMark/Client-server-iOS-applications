import UIKit
import RealmSwift

// Кэш нашего realm'a
final class RealmCacheService {
    
    //    для значения
    func create<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    //    для массива
    func create<T: Object>(_ object: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    //    метод записи в БД
    func read<T: Object>(_ object: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(object)
    }
}
