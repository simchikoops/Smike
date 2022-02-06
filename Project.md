# To-do

* Animation Loops
  Relative motion, relative depth
  
* Include delta depth in track times
  Also in interpolation
  Tests
  
* Tilt to path

* Come to life (animations)
  https://stackoverflow.com/questions/20889860/a-camera-shake-effect-for-spritekit/42895496
  birds. Treadmills?
* Demon track
* Mortal kill
  Mortal groups?
* Gesture attacks
  Show color-graded percentage efficiency, 0-99 (round down)
* Money chutes
  Toss them up to start? And at an angle. Disappear when hit some surfaces.
  Great casino/coin noise on collection.

* Back, to map
* Basic animations

Next: saving state
Then: Map & progression

# Mark III Summary

* No heroes; direct attack on demons
* Demons start in background, move to foreground, then attack & kill mortals
* Level success is surviving a wave without losing too many mortals
* Multiple attack styles with gestures: tap, pinch, twist
* Sky attacks, water attacks (partially hidden), land attacks (from underground).
  Land shorter warning than sky, water special too. Land forms/buildings used to pop out close to mortals.
* Coins fall from the sky from chutes. Over water they disappear; might bounce off surfaces w/ physics
* Coin collection provides attack power
  Coin color per attack type.
* "Bad" coins: round holes. Lose all you have in that category.
* As demons approach they are more efficient to kill; that number is reported. But past 100% the demon is invulernerable and kill(s) made.
* Tracks have a single type of demon, but there are many of them on many tracks.
* 1 demon drags down 1 mortal

# Mark III Monsters

* Ghost
  Fast, weak
* Bat (from below)
  Small target, fast
* Tortoises
  Slow, big, strong
* Devils
  Big, strong, medium speed
  
  
# Flash code
  func showDamage(color: UIColor = .red) {
    guard let node = entity?.node as? SKSpriteNode else { return }
      
    let pulsedRed = SKAction.sequence([
      SKAction.colorize(with: color, colorBlendFactor: 1.0, duration: 0.15),
      SKAction.wait(forDuration: 0.1),
      SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.15)])
    
    node.run(pulsedRed)
  }

# Coins

* Mon - Brass/Silver/Gold - Tap power
* Ingot - Twist power
* Kobundo - Unzoom / general power
  
# More to-do

* Only show track when selected?
* New colors?
  Demon: neon red/pink. Hero: neon blue/green. Mortal: neon yellow.
* Intro/Story scene: use mine shaft to show demons, with text

# Steps

* Saving state
* Syncing with animation and basic sounds
* Supported attacks
* Mass attack
* Advancement
  Map of Japan? Each island. Staman.terrainbackground
* Coins
* Purchases

# Consider

* Title
* Some kind of bonus for leftover power

# Fundamentals

* Ukiyo-e comes to life
  Happens with a rattle and a sound
  Animation, ambient sounds
* Respect for art & culture
* Many sources of variety: prints, demons

# Backfill

* animations
  spawning
  death: warp for mortals?
    https://developer.apple.com/documentation/spritekit/skwarpgeometrygrid/animate_the_warping_of_a_sprite
* sounds

# Level intro script

* Print unadorned; title & artist
* Print shakes & comes to life with special sound; things start moving
* Mortals w/ yellow outline in fast sequence; "Protect the mortals"
* Heroes materialize; "Slide to move, tap to attack"
* Generators begin

# Living prints

* Depth
* Surfaces
* Surface types

# Mission progression
Kyushu, then Shikoku, the southern honshu, then (surprise) Hokkaido (snow), then end up in Tokyo.

Power strikes accrue from level to level. In order to re-play a level with a coin bonus, you risk having to use a strike.

# Demon attack patterns

Each has a secret cycle of when they attack and when they pause. Like two attacks, then wait a while, then two again. So, trigger an attack, then wait for the opportunity.

# Hero types

* Bijin (land): fast comb hits
* Samurai (land): timed strikes (nearness counts)
* Ninja (rooftops, in buildings): also timed strikes
* Birds (air): thrown seeds (up)
* Boatmen (water): Casting?
* Tigers (forest): Pounces (hit multiple)
* Farmers (land): Strike demons burrowing up with implements
* Horses (roads/bridges): Trample (need running start)
* Elephants: Horse-like, for big landscapes
* Flying elephants?

# Gameplay Skills

* Switching heroes
* Understanding hero, demon types
* Memorizing generator, attack patterns
* Speed tapping
* Use of power strike
* Supported attacks
* Earning upgrades

# Hero aspects

* Speed [upgradable]
* Hit points [upgradable]
* Attack type (single)
  Attack strength: [upgradable] some demons can't be hit by some attack types
* (Track length)
* Minimum attack interval [upgradable?]

* Skin (purchasable/customizable)

# Attack types

* Aerial: shoot
* Samurai: fast tap for sword strike
* Bijin: Comb strike?
* Fisherman/Spearmen/archers: Hold to aim
  Facing in one direction
* vs ground: whack-a-mole (before they get strong or invulnerable)
* Secondary attacks with spin gesture? Special, limited attack
  Place a grenade and run, short lifetime. Can hurt other heroes.
  Special attack to slow down, but not damage, demons.

All: catch coins, avoid waves by hiding in gaps

Supported strikes: stronger when at edge with another at adjacent edge. Some demons can only
be hit by combos. Like heroes only (samurai-samurai).

Multi-gesture on area or on attack button? 
Pinch, Rotation, swipe, pan

Galaga-style temporary double-ups?

# Demon attacks

Bombs: if a demon reaches the end of a track, it can set off a bomb that kills mortals elsewhere. Maybe all, maybe just some.

# Strategy

* Quick toggles among heroes, constantly scanning
* Good timing of toriya
* Remembering attack patterns, which have little/no rng
* Supported strikes
* Defense mode? Pinch to defend, zoom to resume. Can't move/attack when defending

# Power strikes (toriya)

* Massive damage to all demons. killing most
* Also revives heroes?
* Start with three at the beginning of a mission, resets at the end
* Earn power strikes with special coin capture

# Colors

* Red: Demons
* Yellow/orange: Mortals
* Blue: Heroes
  Green: selected hero

# Transforms

## Demons
* Black point + 100%
* Vibrance + 75%
* Exposure - 80%
* Brightness + 20%

## Map: Urban 1

# Implementation Nodes

## Components vs Entities
Generic entities (not subclassed.) Scene-editor created entities have precreated node components.
Generated entities create their own node components.

# Models

## Space Invaders

Fun:
* Starts easy, gets hard
* Places to hide
* Offense/defense
* Multiple strategies
* Inherent drama

## Shinobi

Fun:
* Mix of stage types
* Slow gains in experience
* High challenge

# Revenue

* Bonus missions
* Coins for special heroes

# Level design

Principle: Every level should have something new apart from the print. Something taught or revealed.

Some levels allow NO mortals killed.

Hero tracks visible, monster not. Some monster generators visible. Heroes start at 0.5 on the track.

Hero tracks have interesting interactions. Near approaches allow supported attacks. Painful gaps. Differences in length and curviness, but in general, no more than half-circle inscribed.

# Level Attributes

* Print
  * Name
  * Artist, year
* Zones
  * Depth
  * Surface
  * Proximity types (mountain, tree, gate, bridge, etc.)
  * Tilt
  * Spawn sequence
  * Foreground sprite references (don't need heal behind)
* portrait/landscape
* Coin spawn points w/depth
* Mortal highlight color
* Distractor animations
* Music, background sounds

# Coin fountains

Coins fall from the sky, using gravity, can bounce. Heroes must catch them.

Some coins are special (ingots) and worth more than cash.

# Inverse Kinematics

https://www.raywenderlich.com/1158-spritekit-and-inverse-kinematics-with-swift

# Scoreboard

Two orientations.

* Level name
* Coin count
* Level progress?
* Controls: Pause, exit

# Coin system

* Spend on hero attributes
* Buy coins with $
* Kanei Tsuho appearance (square hole)


# Updated Gameplay

Mission sequences with related scenery & demons. Option to buy between scenes.

Challenging stage is all coin fountains, can't lose.

# Gameplay

1 print per level, many levels per mission, ending with boss fight. Pay for bonus missions & special heroes.

Planes of various depths defined on top of print. Plane has a surface type and proximity objects like trees, mountains, buildings, bridges. All mortals to be protected are within a plane. Heroes and demons are scaled to the plane.

Demons arrive and attack the mortals, sucking them into hell if they can. If any of the mortals die you lose. You place heroes in planes to protect them from demons and to fight back against them. Demons attack both mortals and heroes.

Zen points are required to place heroes. Placed clergy increase zen points.

Defeat all the demons the spawn in a level to win the level.

Within a plane, heroes may move back and forth. Some may swim or fly. Mortals mostly stay put. Flying demons move among planes. X placement matters.

Demons have various attacks. 

You earn new heroes with new & better powers. You can use any of them. Arrange your palette of heroes and swipe during the game. Palette is below or beside.

# Boss fights

One giant mortal.

# Missions

Number of levels per mission?
Name missions
Mission 1: Kyushu Peril (etc.)

Cut scenes to start? Picture comes alive.

## Road
## Mountains
## Water
## Snow
## Urban

# Mortals

Brightly colored, color changes. Larger things have more HP. Flash when hit, different color flash when near death. Sucked into the ground when killed with a horrible scream.

### Peasants
### Boats
### Buildings

# Optimization
https://www.hackingwithswift.com/articles/184/tips-to-optimize-your-spritekit-game

# Story

"IN OLD JAPAN the gates of hell have opened. Unseen demons drag mortals to their doom. Only your heroes can save them."

Pre-level:

"PROTECT THE MORTALS" (or mortal)

# Boss images
- https://ukiyo-e.org/image/kruml/warriors47#&gid=1&pid=1
- https://data.ukiyo-e.org/mfa/images/sc162814.jpg
- 01 p 80, 97, 162, 163
- 02 p 9, 107, 143
- 03 p 41, 58

# Monster Image
- 01 p 20, 22, 39, 46 (faces), 59 (fish), _64_ (bats), 92, 94 (birds), [103], 108 (birds), 153 (ghost), 104 (dragon)
- 02 p 153
- 03 p 145 (rat), 154

# Tile images
- 01 p 93

# More images
- 02 p 32 Ninja
- 02 p 104 Progression

- 01 6: turtle; 7, 43, 53: demon; lady ghost: 14; birds: 21; bugs: 27; sealife: 25; masks: 46

- p 46: Masks that laugh at you if you lose

# Good prints
- https://ukiyo-e.org/image/chazen/1980_1067 Vert, water
- https://ukiyo-e.org/image/mfa/sc208280 Horiz, mountain, bridge
- https://ukiyo-e.org/image/wbp/1017108091 Horiz, windy, action, water
- https://ukiyo-e.org/image/mfa/sc129284 horiz, distant, mountains, water
- https://ukiyo-e.org/image/mfa/sc137546 horiz, winter
- https://ukiyo-e.org/image/mfa/sc126832 vert, bridge, distant
- https://ukiyo-e.org/image/bm/AN00518278_001_l vert, distant mountains
- https://ukiyo-e.org/image/mfa/sc208013 horiz, distant mountain
- https://ukiyo-e.org/image/bm/AN00531999_001_l vert, water & mountain
- https://ukiyo-e.org/image/jaodb/Hiroshige_1_Ando-53_Stations_of_the_Tokaido-Snow_at_Yamanaka_Village_Near_Fujikawa-00027073-011228-F06 vert, winter
- https://ukiyo-e.org/image/mfa/sc150121 horiz, clear, winter
- https://ukiyo-e.org/image/honolulu/5841 horiz, combo

  https://ukiyo-e.org/image/mfa/sc172928
  
  https://ukiyo-e.org/image/mfa/sc208863
  https://ukiyo-e.org/image/met/DP141008
  https://ukiyo-e.org/image/mfa/sc146015
  https://ukiyo-e.org/image/famsf/5076163106620055
  https://ukiyo-e.org/image/harvard/HUAM-CARP04028
  https://ukiyo-e.org/image/mia/9160
  https://ukiyo-e.org/image/met/DP141258 vert
  https://ukiyo-e.org/image/mfa/sc143124
  https://ukiyo-e.org/image/chazen/1980_2414
  https://ukiyo-e.org/image/ohmi/Hokusai_Katsushika-36_Fuji-Yuyudo-Inume_Touge-01-07-07-2007-8799-x2000
  https://ukiyo-e.org/image/mfa/sc219453
  https://ukiyo-e.org/image/mfa/sc224667
  https://ukiyo-e.org/image/mfa/sc130503
  https://ukiyo-e.org/image/met/DP141077
  
  https://ukiyo-e.org/image/honolulu/7367
  https://ukiyo-e.org/image/mfa/sc213041#&gid=1&pid=1
  https://ukiyo-e.org/image/mfa/sc128188#&gid=1&pid=1
  https://ukiyo-e.org/image/mfa/sc208929
  https://ukiyo-e.org/image/mfa/sc208985
  https://ukiyo-e.org/image/mfa/sc207822
  https://ukiyo-e.org/image/japancoll/p4500-hiroshige-night-view-of-saruwaka-machi-7413 
  https://ukiyo-e.org/image/mfa/sc208894

# Heroes images

## Samurai "Faithful Samurai"
  https://ukiyo-e.org/image/bm/AN00588016_001_l
  https://ukiyo-e.org/image/mfa/sc234237
  https://ukiyo-e.org/image/japancoll/p185-yoshitora-okuda-tadaemon-fujiwara-no-yukitaka-8628
  https://ukiyo-e.org/image/met/DP132861
  https://ukiyo-e.org/image/mfa/sc234267
  https://ukiyo-e.org/image/bm/AN00460808_001_l
  https://ukiyo-e.org/image/japancoll/p325-yoshiiku-kusunoki-shichorozaemon-masatomo-11085

# Scaling
- Long side: 1536 px

# Fonts
* https://www.dafont.com/moyko.font?text=The+quick+brown+fox&psize=s&back=theme
* https://www.dafont.com/katana.font

# Titles

* Heroes and Demons (Heroes/Demons)

# Acknowledgements

* "Sound effects obtained from https://www.zapsplat.com“

