# To-do
  
* DashNode, PrintNode under scene
  Scene.rootnode become printnode
  Vert/horiz switching

# Steps

* Top-level configuration
* Level loading
* Layouts: portrait and landscape
  Hero wells change orientation too

# Fundamentals

* Ukiyo-e come to life
* Respect for art & culture
* Many sources of variety: prints, heroes, demons

# Revenue

* Bonus missions
* Coins for special heroes

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

# Zones

* Defined in editor
* Node containing action within; scaled as a group

# Player Interaction

Primary: dragging heroes to planes. Or, select tap and place tap. Heroes are proxies that can't be directly controlled (mostly because of phone space).

"Place heroes to save mortals" boxed by highlight color

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

# Story

"IN OLD JAPAN the gates of hell have opened. Unseen demons drag mortals to their doom. Only your heroes can save them."

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


# Scaling
- Long side: 1536 px

# Fonts
* https://www.dafont.com/moyko.font?text=The+quick+brown+fox&psize=s&back=theme
* https://www.dafont.com/katana.font

# Titles

* Heroes and Demons (Heroes/Demons)

