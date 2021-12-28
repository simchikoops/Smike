import SpriteKit

struct PhysicsInfo: OptionSet, Hashable {
  let rawValue: UInt32
  
  static let hero = PhysicsInfo(rawValue: 1 << 0)
  static let demon = PhysicsInfo(rawValue: 1 << 1)
  static let mortal = PhysicsInfo(rawValue: 1 << 2)
  static let heroAttack = PhysicsInfo(rawValue: 1 << 3)
  static let demonAttack = PhysicsInfo(rawValue: 1 << 4)
    
  static var contactTests: [PhysicsInfo: [PhysicsInfo]] = [
    .heroAttack: [.demon],
    .demonAttack: [.hero, .mortal]
  ]
  
  var categoryBitMask: UInt32 {
    return rawValue
  }
  
  var contactTestBitMask: UInt32 {
    let bitMask = PhysicsInfo
      .contactTests[self]?
      .reduce(PhysicsInfo(), { result, physicsInfo in
        return result.union(physicsInfo)
      })
    
    return bitMask?.rawValue ?? 0
  }
}
