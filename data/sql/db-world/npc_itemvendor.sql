-- --------------------------------------------------------------------------------------
--	ItemVendor - 606600
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 606600,
@Model 		:= 3088, -- Dwarf Blacksmith
@Name 		:= "Carlitos Balfarre",
@Title 		:= "Item Vendor",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 129,
@Scale		:= 1.0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "",
@Script 	:= "npc_itemvendor";

-- NPC CREATURE
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `AiName`, `ScriptName`) VALUES(@Entry, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra, @AIName, @Script);

-- NPC MODEL
DELETE FROM `creature_template_model` WHERE `CreatureID` = @Entry;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(@Entry, 0, @Model, 1, 1, 0);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 11343, 0, 0, 18019); -- Black/Purple Staff, None

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Good day $N. Carlitos Balfarre at your service.');


DELETE FROM `npc_vendor` WHERE `entry` BETWEEN @Entry AND @Entry+4;
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES
-- Weapons
(@Entry, 40388), -- journeys-end
(@Entry, 40384), -- betrayer-of-humanity
(@Entry, 40345), -- broken-promise
(@Entry, 40395), -- torch-of-holy-fire
(@Entry, 40396), -- the-turning-tide
(@Entry, 40400), -- wall-of-terror
(@Entry, 40385), -- envoy-of-mortality
(@Entry, 40401), -- voice-of-reason
(@Entry, 40402), -- last-laugh
(@Entry, 39763), -- wraith-strike
(@Entry, 39468), -- the-stray
(@Entry, 40383), -- calamitys-grasp
(@Entry, 39714), -- webbed-death
(@Entry, 40386), -- sinister-revenge
(@Entry, 40406), -- inevitable-defeat
(@Entry, 40189), -- angry-dread
(@Entry, 40192), -- accursed-spine
(@Entry, 39766), -- matriarchs-spawn
(@Entry, 40273), -- surplus-limb
(@Entry, 40350), -- urn-of-lost-memories
(@Entry, 39426), -- wand-of-the-archlich
(@Entry, 40245), -- fading-glow
(@Entry, 39712), -- gemmed-wand-of-the-nerubians
-- tiers
(@Entry+1, 40565), -- valorous-scourgeborne-faceguard
(@Entry+1, 40568), -- valorous-scourgeborne-pauldrons
(@Entry+1, 40559), -- valorous-scourgeborne-chestguard
(@Entry+1, 40563), -- valorous-scourgeborne-handguards
(@Entry+1, 40557), -- valorous-scourgeborne-shoulderplates
(@Entry+1, 40550), -- valorous-scourgeborne-battleplate
(@Entry+1, 40552), -- valorous-scourgeborne-gauntlets
(@Entry+1, 40556), -- valorous-scourgeborne-legplates
(@Entry+1, 40467), -- valorous-dreamwalker-cover
(@Entry+1, 40470), -- valorous-dreamwalker-mantle
(@Entry+1, 40469), -- valorous-dreamwalker-vestments
(@Entry+1, 40466), -- valorous-dreamwalker-gloves
(@Entry+1, 40473), -- valorous-dreamwalker-headguard
(@Entry+1, 40494), -- valorous-dreamwalker-shoulderpads
(@Entry+1, 40460), -- valorous-dreamwalker-handguards
(@Entry+1, 40507), -- valorous-cryptstalker-spaulders
(@Entry+1, 40504), -- valorous-cryptstalker-handguards
(@Entry+1, 40506), -- valorous-cryptstalker-legguards
(@Entry+1, 40416), -- valorous-frostfire-circlet
(@Entry+1, 40419), -- valorous-frostfire-shoulderpads
(@Entry+1, 40415), -- valorous-frostfire-gloves
(@Entry+1, 40417), -- valorous-frostfire-leggings
(@Entry+1, 40573), -- valorous-redemption-spaulders
(@Entry+1, 40569), -- valorous-redemption-tunic
(@Entry+1, 40570), -- valorous-redemption-gloves
(@Entry+1, 40572), -- valorous-redemption-greaves
(@Entry+1, 40581), -- valorous-redemption-faceguard
(@Entry+1, 40584), -- valorous-redemption-shoulderguards
(@Entry+1, 40579), -- valorous-redemption-breastplate
(@Entry+1, 40580), -- valorous-redemption-handguards
(@Entry+1, 40578), -- valorous-redemption-shoulderplates
(@Entry+1, 40574), -- valorous-redemption-chestpiece
(@Entry+1, 40450), -- valorous-shoulderpads-of-faith
(@Entry+1, 40445), -- valorous-gloves-of-faith
(@Entry+1, 40459), -- valorous-mantle-of-faith
(@Entry+1, 40454), -- valorous-handwraps-of-faith
(@Entry+1, 40499), -- valorous-bonescythe-helmet
(@Entry+1, 40502), -- valorous-bonescythe-pauldrons
(@Entry+1, 40496), -- valorous-bonescythe-gauntlets
(@Entry+1, 40500), -- valorous-bonescythe-legplates
(@Entry+1, 40516), -- valorous-earthshatter-helm
(@Entry+1, 40514), -- valorous-earthshatter-hauberk
(@Entry+1, 40524), -- valorous-earthshatter-shoulderguards
(@Entry+1, 40523), -- valorous-earthshatter-chestguard
(@Entry+1, 40520), -- valorous-earthshatter-grips
(@Entry+1, 40522), -- valorous-earthshatter-war-kilt
(@Entry+1, 40510), -- valorous-earthshatter-headpiece
(@Entry+1, 40513), -- valorous-earthshatter-spaulders
(@Entry+1, 40508), -- valorous-earthshatter-tunic
(@Entry+1, 40512), -- valorous-earthshatter-legguards
(@Entry+1, 40421), -- valorous-plagueheart-circlet
(@Entry+1, 40424), -- valorous-plagueheart-shoulderpads
(@Entry+1, 40423), -- valorous-plagueheart-robe
(@Entry+1, 40420), -- valorous-plagueheart-gloves
(@Entry+1, 40528), -- valorous-dreadnaught-helmet
(@Entry+1, 40530), -- valorous-dreadnaught-shoulderplates
(@Entry+1, 40529), -- valorous-dreadnaught-legplates
-- ARMOR
(@Entry+2, 44006), -- obsidian-greathelm
(@Entry+2, 44007), -- headpiece-of-reconciliation
(@Entry+2, 40543), -- blue-aspect-helm
(@Entry+2, 40298), -- faceguard-of-the-succumbed
(@Entry+2, 40562), -- hood-of-rationality
(@Entry+2, 39719), -- mantle-of-the-locusts
(@Entry+2, 40286), -- mantle-of-the-corrupted
(@Entry+2, 40539), -- chestguard-of-the-recluse
(@Entry+2, 44002), -- the-sanctums-flowing-vestments
(@Entry+2, 43998), -- chestguard-of-flagrant-prowess
(@Entry+2, 40194), -- blanketing-robes-of-snow
(@Entry+2, 40734), -- bracers-of-dalarans-parapets
(@Entry+2, 40330), -- bracers-of-unrelenting-attack
(@Entry+2, 44008), -- unsullied-cuffs
(@Entry+2, 39765), -- sinners-bindings
(@Entry+2, 40282), -- slime-stream-bands
(@Entry+2, 34438), -- skyshatter-bracers
(@Entry+2, 40324), -- bands-of-mutual-respect
(@Entry+2, 39764), -- bindings-of-the-hapless-prey
(@Entry+2, 40186), -- thrusting-bands
(@Entry+2, 40736), -- armguard-of-the-tower-archer
(@Entry+2, 40347), -- zelieks-gauntlets
(@Entry+2, 40541), -- frosted-adroit-handguards
(@Entry+2, 40302), -- benefactors-gauntlets
(@Entry+2, 40564), -- winter-spectacle-gloves
(@Entry+2, 39759), -- ablative-chitin-girdle
(@Entry+2, 40278), -- girdle-of-chivalry
(@Entry+2, 40561), -- leash-of-heedless-magic
(@Entry+2, 40205), -- stalk-skin-belt
(@Entry+2, 40275), -- depraved-linked-belt
(@Entry+2, 40259), -- waistguard-of-divine-grace
(@Entry+2, 40271), -- sash-of-solitude
(@Entry+2, 40301), -- cincture-of-polarity
(@Entry+2, 40327), -- girdle-of-recuperation
(@Entry+2, 40260), -- belt-of-the-tortured
(@Entry+2, 40589), -- legplates-of-sovereignty
(@Entry+2, 40294), -- riveted-abomination-leggings
(@Entry+2, 40560), -- leggings-of-the-wanton-spellcaster
(@Entry+2, 44011), -- leggings-of-the-honored
(@Entry+2, 40379), -- legguards-of-the-boneyard
(@Entry+2, 40331), -- leggings-of-failed-escape
(@Entry+2, 40398), -- leggings-of-mortal-arrogance
(@Entry+2, 40318), -- legplates-of-double-strikes
(@Entry+2, 40297), -- sabatons-of-endurance
(@Entry+2, 40591), -- melancholy-sabatons
(@Entry+2, 39706), -- sabatons-of-sudden-reprisal
(@Entry+2, 40519), -- footsteps-of-malygos
(@Entry+2, 40243), -- footwraps-of-vile-deceit
(@Entry+2, 40558), -- arcanic-tramplers
(@Entry+2, 40549), -- boots-of-the-renewed-flight
(@Entry+2, 40187), -- poignant-sabatons
(@Entry+2, 40236), -- serene-echoes
(@Entry+2, 39701), -- dawnwalkers
(@Entry+2, 40367), -- boots-of-the-great-construct
(@Entry+2, 34565), -- skyshatter-boots
-- ACCESORIES
(@Entry+3, 40387), -- boundless-ambition
(@Entry+3, 39392), -- veiled-amulet-of-life
(@Entry+3, 44664), -- favor-of-the-dragon-queen
(@Entry+3, 44661), -- wyrmrest-necklace-of-power
(@Entry+3, 44662), -- life-binders-locket
(@Entry+3, 44665), -- nexus-war-champion-beads
(@Entry+3, 40403), -- drape-of-the-deadly-foe
(@Entry+3, 40722), -- platinum-mesh-cloak
(@Entry+3, 44005), -- pennant-cloak
(@Entry+3, 40723), -- disguise-of-the-kumiho
(@Entry+3, 40724), -- cloak-of-kea-feathers
(@Entry+3, 40370), -- gatekeeper
(@Entry+3, 40107), -- sand-worn-band
(@Entry+3, 40075), -- ruthlessness
(@Entry+3, 43993), -- greatring-of-collision
(@Entry+3, 39401), -- circle-of-death
(@Entry+3, 40399), -- signet-of-manifested-pain
(@Entry+3, 40585), -- signet-of-the-kirin-tor
(@Entry+3, 40080), -- lost-jewel
(@Entry+3, 40474), -- surge-needle-ring
(@Entry+3, 40717), -- ring-of-invincibility
(@Entry+3, 40719), -- band-of-channeled-magic
(@Entry+3, 40375), -- ring-of-decaying-beauty
(@Entry+3, 40074), -- strong-handed-ring
(@Entry+3, 40718), -- signet-of-the-impregnable-fortress
(@Entry+3, 40108), -- seized-beauty
(@Entry+3, 40720), -- renewal-of-life
(@Entry+3, 37220), -- essence-of-gossamer
(@Entry+3, 40257), -- defenders-code
(@Entry+3, 40256), -- grim-toll
(@Entry+3, 37390), -- meteorite-whetstone
(@Entry+3, 40255), -- dying-curse
(@Entry+3, 40431), -- fury-of-the-five-flights
(@Entry+3, 40684), -- mirror-of-truth
(@Entry+3, 39229), -- embrace-of-the-spider
(@Entry+3, 37111), -- soul-preserver
(@Entry+3, 40432), -- illustration-of-the-dragon-soul
(@Entry+3, 44253), -- darkmoon-card-greatness agi
(@Entry+3, 42987), -- darkmoon-card-greatness str
(@Entry+3, 44255), -- darkmoon-card-greatness int
(@Entry+3, 42988), -- darkmoon-card-illusion
(@Entry+3, 40822), -- sigil-of-the-frozen-conscience
(@Entry+3, 40207), -- sigil-of-awareness
(@Entry+3, 40867), -- sigil-of-the-wild-buck
(@Entry+3, 40321), -- idol-of-the-shooting-star
(@Entry+3, 39757), -- idol-of-worship
(@Entry+3, 40342), -- idol-of-awakening
(@Entry+3, 40705), -- libram-of-renewal
(@Entry+3, 40707), -- libram-of-obstruction
(@Entry+3, 42852), -- deadly-gladiators-libram-of-fortitude
(@Entry+3, 40267), -- totem-of-hex
(@Entry+3, 42607), -- deadly-gladiators-totem-of-indomitability
(@Entry+3, 40709), -- totem-of-forest-growth
-- EXTRAS
(@Entry+4, 41599), -- frostweave-bag
(@Entry+4, 41597), -- abyssal-bag
(@Entry+4, 41165), -- saronite-razorheads
(@Entry+4, 41164), -- mammoth-cutters
(@Entry+4, 46377), -- flask-of-endless-rage
(@Entry+4, 46378), -- flask-of-pure-mojo
(@Entry+4, 46379), -- flask-of-stoneblood
(@Entry+4, 46376), -- flask-of-the-frost-wyrm
(@Entry+4, 43015), -- fish-feast
(@Entry+4, 40212), -- potion-of-wild-magic
(@Entry+4, 22828), -- insane-strength-potion
(@Entry+4, 40093), -- indestructible-potion
(@Entry+4, 40211), -- potion-of-speed
(@Entry+4, 33447), -- runic-healing-potion
(@Entry+4, 33448); -- runic-mana-potion

