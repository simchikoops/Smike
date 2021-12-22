# To-do

* Attack Node -> attack entity (to get update, and remove when spent)
* Demon.hit(force)
 
# Steps

* Mortal component
* Demon attacks
  vs. Heroes: hero looses alpha and is knocked out for a while. Harder hits, knocked out longer. While knocked out, can't move/attack or support others.
* Scene completion (win/loss conditions)

# Consider

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

# Hero aspects

* Speed
* Size (vulnerability)
* Hit points
* Attack type (single)
  Attack strength: some demons can't be hit by some attack types
* (Track length)
* Minimum attack interval

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

# Strategy

* Quick toggles among heroes, constantly scanning
* Good timing of toriya
* Remembering attack patterns, which have little/no rng
* Supported strikes
* Defense mode? Pinch to defend, zoom to resume. Can't move/attack when defending

# Power strikes (toriya)

* Stops all demons (except bosses?)
* Upgrade: also revives heroes

# Colors

* Red: Demons
* Blue: Mortals
* Yello: Selected hero

# Fundamentals

* Ukiyo-e come to life
* Respect for art & culture
* Many sources of variety: prints, heroes, demons

# Implementation Nodes

## Components vs Entities
Generic entities (not subclassed.) Scene-editor created entities have precreated node components.
Generated entities creat their own node components.

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

# Tracks

* Defined in editor
* Continuous scaling

# Coin fountains

Coins fall from the sky, using gravity, can bounce. Heroes must catch them.

Some coins are special (ingots) and worth more than cash.

# Inverse Kinematics

https://www.raywenderlich.com/1158-spritekit-and-inverse-kinematics-with-swift

# Player Interaction

More:
* Arranging palette of heroes for quick access
* Tor-e-a strike with double tap. X per mission (save!)
* Tap for bonus coins (quick appear/disappear)

# Scoreboard

Two orientations.

* Level name
* Zen count
* Coin count
* Level progress?
* Controls: Pause, exit

# Coin system

* Earn by completing levels
* Also earn by tapping fast on coins
* Spend on special heroes & torea strikes
* Buy coins with $
* Kanei Tsuho appearance (square hole)

# Zen system

* Priests earn zen
* Each hero has a zen cost
* Also zen pop up on screen fleetingly
* Symbol: Enso? Yin-yang? Lotus flower?

# Updated Gameplay

Mission sequences with related scenery & demons. No boss fights, but interspersed with challenging stages. Option to buy between scenes.

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

One giant demon that moves among zones. Special behaviour class, but otherwise a normal level scene.

# Missions

Number of levels per mission?

## Road
## Mountains
## Water
## Snow
## Urban

Purchasable:
## Bridges
## Castles
## Temples

# Heros

Distinctive shapes needed for smaller sizes.

## Warriors (projecting weapons)
### Samurai
https://ukiyo-e.org/image/waseda/006-1522 (More from this artist)
### Ronin
### Ninja
### Lord

Direct attacks, delaying attacks, area attacks.

## Protectors/Frighteners
### Fat guys
### Martial artist
### Actors?

## Healers (skinny)
### Bijin
### Geisha

## Clerics (roundish)
### Shinto Priest
### Buddhist Priest
### Buddhist Nuns
### Daoist?
### Zen master

# Demons

### Masked samurai: swords
### Gargoyles: claws
### Bats: divebomb
### Turtles: bites

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
- 01 p 20, 22, 39, 46 (faces), 59 (fish), _64_ (bats), 92, 94 (birds), [103], 108 (birds), 153 (ghost)
- 02 p 153
- 03 p 145 (rat), 154

# Tile images
- 01 p 93

# More images
- 02 p 32 Ninja
- 02 p 104 Progression

- 01 6: turtle; 7, 43, 53: demon; lady ghost: 14; birds: 21; bugs: 27; sealife: 25; masks: 46

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

