/*

# Item Vendor NPC #


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC (ID: 606600)
- Script: npc_itemvendor
- Config: Yes
- SQL: No



### CREDITS
------------------------------------------------------------------------------------------------------------------
![Styx](https://stygianthebest.github.io/assets/img/avatar/avatar-128.jpg "Styx")
![StygianCore](https://stygianthebest.github.io/assets/img/projects/stygiancore/StygianCore.png "StygianCore")

##### This module was created for [StygianCore](https://rebrand.ly/stygiancoreproject). A World of Warcraft 3.3.5a Solo/LAN repack by StygianTheBest | [GitHub](https://rebrand.ly/stygiangithub) | [Website](https://rebrand.ly/stygianthebest))

#### Additional Credits

- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [OwnedCore](http://ownedcore.com/)
- [ModCraft.io](http://modcraft.io/)
- [MMO Society](https://www.mmo-society.com/)
- [AoWoW](https://wotlk.evowow.com/)
- [More credits are cited in the sources](https://github.com/StygianTheBest)

### LICENSE
------------------------------------------------------------------------------------------------------------------
This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Cell.h"
#include "CellImpl.h"
#include "Chat.h"
#include "CombatAI.h"
#include "Configuration/Config.h"
#include "DBCStores.h"
#include "DBCStructure.h"
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Unit.h"


uint32 roll;
bool ItemVendorEnableModule;
bool ItemVendorAnnounceModule;
uint32 ItemVendorMessageTimer;
uint32 ItemVendorEmoteSpell;

class ItemVendorConfig : public WorldScript
{
public:
    ItemVendorConfig() : WorldScript("ItemVendorConfig_conf", {
        WORLDHOOK_ON_BEFORE_CONFIG_LOAD
    }) { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            ItemVendorEnableModule = sConfigMgr->GetOption<bool>("ItemVendor.Enable", 1);
            ItemVendorAnnounceModule = sConfigMgr->GetOption<bool>("ItemVendor.Announce", 1);
            ItemVendorMessageTimer = sConfigMgr->GetOption<uint32>("ItemVendor.MessageTimer", 60000);
            ItemVendorEmoteSpell = sConfigMgr->GetOption<uint32>("ItemVendor.EmoteSpell", 44940);

            // Enforce Min/Max Time
            if (ItemVendorMessageTimer != 0)
                if (ItemVendorMessageTimer < 60000 || ItemVendorMessageTimer > 300000)
                    ItemVendorMessageTimer = 60000;
        }
    }
};

class ItemVendorAnnounce : public PlayerScript
{

public:

    ItemVendorAnnounce() : PlayerScript("ItemVendorAnnounce", {
        PLAYERHOOK_ON_LOGIN
    }) {}

    void OnPlayerLogin(Player* player)
    {
        // Announce Module
        if (ItemVendorAnnounceModule)
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00ItemVendorNPC |rmodule.");
    }
};

class npc_itemvendor : public CreatureScript
{

public:

    npc_itemvendor() : CreatureScript("npc_itemvendor") { }


    bool OnGossipHello(Player* player, Creature* creature)
    {

        if (!ItemVendorEnableModule)
            return false;

        ClearGossipMenuFor(player);

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface/ICONS/Inv_axe_113:24:24:-18|t[Weapons]", GOSSIP_SENDER_MAIN, 1);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface/ICONS/inv_helmet_29:24:24:-18|t[Tiers]", GOSSIP_SENDER_MAIN, 2);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface/ICONS/inv_chest_cloth_04:24:24:-18|t[Armors]", GOSSIP_SENDER_MAIN, 3);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface/ICONS/Inv_misc_cape_18:24:24:-18|t[Accessories]", GOSSIP_SENDER_MAIN, 4);

        player->PlayerTalkClass->SendGossipMenu(606600, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!ItemVendorEnableModule)
            return false;

        player->PlayerTalkClass->ClearMenus();

        if (action >= 1 && action <= 4) {
            player->GetSession()->SendListInventory(creature->GetGUID(), action);
            return true;
        }


        player->PlayerTalkClass->SendCloseGossip();
        return true;
    }


    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature * creature) : ScriptedAI(creature) { }

        uint32 MessageTimer = 0;

        // Called once when client is loaded
        void Reset()
        {
            if (ItemVendorMessageTimer != 0)
                MessageTimer = urand(ItemVendorMessageTimer, 300000); // 1-5 minutes
        }

        // Called at World update tick
        void UpdateAI(const uint32 diff)
        {
            // If Enabled
            if (ItemVendorEnableModule && ItemVendorMessageTimer != 0)
            {
                if (MessageTimer <= diff)
                {
                    if (ItemVendorEmoteSpell != 0)
                        me->CastSpell(me, ItemVendorEmoteSpell);

                    MessageTimer = urand(ItemVendorMessageTimer, 300000);
                }
                else { MessageTimer -= diff; }
            }
        }
    };

    // CREATURE AI
    CreatureAI * GetAI(Creature * creature) const
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddNPCItemVendorScripts()
{
    new ItemVendorConfig();
    new ItemVendorAnnounce();
    new npc_itemvendor();
}
