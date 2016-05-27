

import UIKit
import CoreData

class Note: NSManagedObject {
    
    @NSManaged var noteContext:String
    @NSManaged var noteImage:NSData

}
