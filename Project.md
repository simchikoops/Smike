# To-do

* Tutorial
  Shoot coins out of Fuji!
  Not intro/splash; that's different
  "First Skill: Save strength by striking demons when they are close. Don't wait too long!"
  LEARN SKILL
  Give feedback & repeat if not good. "Good! You saved strength and dispelled the demon."
  "Too late! Strike sooner." "Too early! Strike later to save strength for other demons."
  "Second Skill: Gather coins before they roll away."
  LEARN SKILL
  More feedback & repeat, then final message.
  "Oops! You missed all the coins. Grab the coins quickly." TRY AGAIN
  "Good! You gathered x of 3 coins."
  "You are now ready to combat Hokusai's demons!" CONTINUE
  
* Other coin types
* Coin depth? warp coins

* Full level

Then: Map & progression

# Steps

* Back, to map
* Ground attacks
* Water attacks
* saving state
* challenging stages
  coin capture only
* "boss fights"
  single big mortal
* Intro--print?
  Set up conflict: demons catch & kill mortals

# More to-do

* Tilt to path (option?)
* Re-use actions?
* Great casino/coin noise on collection. Coins disappear offscreen or elsewhere
* Pinch, swipe attacks
* Localize

# Bonus points

* Earn for leftover point, living mortals
* Spend pre-level for power, pinches (both non-transferable), and swipes.
  Store on map.

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
* "Bad" coins: round holes. Lose all you have in that category?
* As demons approach they are more efficient to kill; that number is reported. But past 100% the demon is invulernerable and kill(s) made.
* Tracks have a single type of demon, but there are many of them on many tracks.
* 1 demon drags down 1 mortal

# Mark III Monsters

* Ghost
* Bat (from below)
  Small target, fast
* Tortoises
* Devils
* Tree dweller: peeks out n times, hit on n - 1
  
# Coins/Attacks

* Mon - Brass/Silver/Gold (silver/gold highlights only?) - Tap power
  100, 200, 300
  
  Attacks take 25 - 200 point (25 perfect, 200 worst)
  Re-initialized each level
* Silver coin? / Kobudo - Pinch - all in the generator
  Always starts at 0, non-transferrable
* Gold coin? / Ingot - swipe - clears all
  Transferrable to higher levels (capped at n ~ 5)
  
# Consider

* Some kind of bonus for leftover power, mortals
  Frame reveal time? Show frame for best hit time
* Bonus levels: catch all the coins? challenging stage
* Tutorial
  Picture w/o mortals. TutorialScene from LevelScene?
  "Catch coins before they disappear"
  "Good! Coins give you power to stop demons"
  "Stop demons when they are near but before they dive onto mortals."
  "Good! You stopped the demon using little power."
  "Be patient! Stopping demons at a distance uses a lot of power."
* 3d coin chutes? show edge-on, or warp

# Fundamentals

* Ukiyo-e comes to life
* Respect for art & culture
* Many sources of variety: prints, demons

# Backfill

* animations
  spawning
  death: warp for mortals?
    https://developer.apple.com/documentation/spritekit/skwarpgeometrygrid/animate_the_warping_of_a_sprite
* sounds

# Living prints

* Depth
* Surfaces
* Surface types

# Mission progression
Kyushu, then Shikoku, the southern honshu, then (surprise) Hokkaido (snow), then end up in Tokyo.

Power strikes accrue from level to level. In order to re-play a level with a coin bonus, you risk having to use a strike.

# Special Scale Factors
When print is smaller than the canvas.

* Tutorial: 0.867

# Transforms

## Demons
* Black point + 100%
* Vibrance + 75%
* Exposure - 80%
* Brightness + 20%

## Map: Urban 1

# Implementation Notes

## Components vs Entities
Generic entities (not subclassed.) Scene-editor created entities have precreated node components.
Generated entities create their own node components.

# Revenue

* Bonus quests

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

# Scoreboard

Two orientations.

* Level name
* Coin count
* Level progress?
* Controls: Pause, exit


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

# Optimization
https://www.hackingwithswift.com/articles/184/tips-to-optimize-your-spritekit-game

# Story

"IN OLD JAPAN the gates of hell have opened. Unseen demons drag mortals to their doom. Only you can save them!"

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
  
  https://japaneseprints.org/hokusai/laughing-demon/
  https://ukiyo-e.org/image/bm/AN00536251_001_l
  https://ukiyo-e.org/image/mfa/sc226738

# Scaling
- Long side: 1536 px

# Fonts
* https://www.dafont.com/moyko.font?text=The+quick+brown+fox&psize=s&back=theme
* https://www.dafont.com/katana.font

# Titles

* Hokusai's Demons
* Heroes and Demons (Heroes/Demons)


# Acknowledgements

* "Sound effects obtained from https://www.zapsplat.com“

