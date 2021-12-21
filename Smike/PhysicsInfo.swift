import SpriteKit

struct PhysicsInfo: OptionSet, Hashable {
  let rawValue: UInt32
  
  static let hero = PhysicsInfo(rawValue: 1 << 0) // 1
  static let demon = PhysicsInfo(rawValue: 1 << 1) // 2
  static let heroAttack = PhysicsInfo(rawValue: 1 << 2) // 4
  static let demonAttack = PhysicsInfo(rawValue: 1 << 3) // 8
    
  static var contactTests: [PhysicsInfo: [PhysicsInfo]] = [
    .heroAttack: [.demon, .hero],
    .demonAttack: [.hero, .demon]
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
