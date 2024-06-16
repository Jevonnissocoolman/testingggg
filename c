Oops! The game crashed:
/Users/Jevonn/Library/Application Support/Bal...:526: attempt to index a nil value

Additional Context:
Balatro Version: 1.0.1f-FULL
Modded Version: 1.0.0-ALPHA-0615b-STEAMODDED
Love2D Version: 11.5.0
Lovely Version: 0.5.0-beta5
Steamodded Mods:
    1: Cryptid by MathIsFun_, Balatro Discord [ID: Cryptid, Version: 0.3.3e]
    2: Talisman by MathIsFun_ [ID: Talisman, Version: 1.2.1]

Stack Traceback
===============
(3) Lua method 'calculate' at line 526 of chunk '"/Users/Jevonn/Library/Application Support/Bal..."]'
Local variables:
 self = table: 0x011e4c0d00  {discovered:true, alerted:true, order:9, object_type:Joker, registered:true (more...)}
 card = table: 0x030e851a48  {STATIONARY:false, ability:table: 0x012b753428, area:table: 0x017d5d8680 (more...)}
 context = table: 0x030de79de8  {other_card:table: 0x017d670078, retrigger_joker_check:true}
 (for index) = number: 19
 (for limit) = number: 28
 (for step) = number: 1
 i = number: 19
 jkr = table: 0x017d670078  {STATIONARY:false, ability:table: 0x030e096a70, area:table: 0x017d5d8680 (more...)}
 (for generator) = C function: next
 (for state) = table: 0x030e096a70  {name:cry-SUS, h_mult:0, d_size:0, extra_value:0, perma_bonus:0, type:, used_round:5 (more...)}
 (for control) = userdata: NULL
 k = string: "chosen_card"
 v = table: 0x030e108ab8  {seal:Red, ability:table: 0x017d5d74a0, ability_UIBox_table:table: 0x030dd42408 (more...)}
 (for generator) = C function: next
 (for state) = table: 0x030e108ab8  {seal:Red, ability:table: 0x017d5d74a0, ability_UIBox_table:table: 0x030dd42408 (more...)}
 (for control) = userdata: NULL
 _k = string: "seal"
 _v = string: "Red"
 (*temporary) = nil
 (*temporary) = string: "%.13f"
 (*temporary) = string: "0.3684029515676"
 (*temporary) = number: 2.23893e-314
 (*temporary) = number: 4.26652e+10
 (*temporary) = number: 2.23886e-314
 (*temporary) = number: 2.31209
 (*temporary) = number: 10
 (*temporary) = table: 0x030e789798  {1:table: 0x030e9c46e8}
 (*temporary) = number: 1
 (*temporary) = number: 2.37336e-314
 (*temporary) = number: 0.352
 (*temporary) = number: 0
 (*temporary) = number: 0.327776
 (*temporary) = number: 0
 (*temporary) = number: 0.004
 (*temporary) = string: "attempt to index a nil value"
(4) Lua upvalue 'ccj' at file 'card.lua:2473'
Local variables:
 self = table: 0x030e851a48  {STATIONARY:false, ability:table: 0x012b753428, area:table: 0x017d5d8680 (more...)}
 context = table: 0x030de79de8  {other_card:table: 0x017d670078, retrigger_joker_check:true}
 obj = table: 0x011e4c0d00  {discovered:true, alerted:true, order:9, object_type:Joker, registered:true (more...)}
(5) Lua upvalue 'cj' at file 'main.lua:727'
Local variables:
 self = table: 0x030e851a48  {STATIONARY:false, ability:table: 0x012b753428, area:table: 0x017d5d8680 (more...)}
 context = table: 0x030de79de8  {other_card:table: 0x017d670078, retrigger_joker_check:true}
(6) Lua method 'calculate_joker' at file 'Cryptid.lua:62' (from mod with id Cryptid)
Local variables:
 self = table: 0x030e851a48  {STATIONARY:false, ability:table: 0x012b753428, area:table: 0x017d5d8680 (more...)}
 context = table: 0x030de79de8  {other_card:table: 0x017d670078, retrigger_joker_check:true}
(7) Lua method 'calculate_joker' at file 'Cryptid.lua:116' (from mod with id Cryptid)
Local variables:
 self = table: 0x017d670078  {STATIONARY:false, ability:table: 0x030e096a70, area:table: 0x017d5d8680 (more...)}
 context = table: 0x030dea9cf8  {game_over:false, end_of_round:true}
 ret = table: 0x030df7c4d0  {joker_repetitions:table: 0x030e253bf0, message:Impostor!}
 (for index) = number: 13
 (for limit) = number: 28
 (for step) = number: 1
 i = number: 13
(8) Lua field 'func' at file 'functions/state_events.lua:99'
Local variables:
 game_over = boolean: false
 game_won = boolean: false
 (for index) = number: 19
 (for limit) = number: 28
 (for step) = number: 1
 i = number: 19
 eval = nil
(9) Lua method 'handle' at file 'engine/event.lua:55'
Local variables:
 self = table: 0x012b7b7f00  {trigger:after, func:function: 0x030e210710, created_on_pause:false, start_timer:true (more...)}
 _results = table: 0x012c08e890  {blocking:true, completed:false, pause_skip:false, time_done:true}
(10) Lua method 'update' at file 'engine/event.lua:182'
Local variables:
 self = table: 0x012c093088  {queue_timer:729.27307280824, queues:table: 0x012c0930d0, queue_last_processed:723.49999999967 (more...)}
 dt = number: 0.0166533
 forced = nil
 (for generator) = C function: next
 (for state) = table: 0x012c0930d0  {other:table: 0x012c093300, base:table: 0x012c093228, unlock:table: 0x012c0931e0 (more...)}
 (for control) = userdata: NULL
 k = string: "base"
 v = table: 0x012c093228  {1:table: 0x017d6d9300, 2:table: 0x017d65bec0, 3:table: 0x017d293110, 4:table: 0x012b753058 (more...)}
 blocked = boolean: false
 i = number: 10
 results = table: 0x012c08e890  {blocking:true, completed:false, pause_skip:false, time_done:true}
(11) Lua upvalue 'upd' at file 'game.lua:2568'
Local variables:
 self = table: 0x010ede8680  {F_SWAP_AB_BUTTONS:false, F_SWAP_XY_BUTTONS:false, F_GUIDE:false, WINDOWTRANS:table: 0x017d6d4e70 (more...)}
 dt = number: 0.0166533
 http_resp = nil
(12) Lua upvalue 'gameUpdateRef' at file 'main.lua:707'
Local variables:
 self = table: 0x010ede8680  {F_SWAP_AB_BUTTONS:false, F_SWAP_XY_BUTTONS:false, F_GUIDE:false, WINDOWTRANS:table: 0x017d6d4e70 (more...)}
 dt = number: 0.0166533
(13) Lua upvalue 'upd' at file 'main.lua:971'
Local variables:
 arg_298_0 = table: 0x010ede8680  {F_SWAP_AB_BUTTONS:false, F_SWAP_XY_BUTTONS:false, F_GUIDE:false, WINDOWTRANS:table: 0x017d6d4e70 (more...)}
 arg_298_1 = number: 0.0166533
(14) Lua upvalue 'upd' at line 136 of chunk '"/Users/Jevonn/Library/Application Support/Bal..."]'
Local variables:
 self = table: 0x010ede8680  {F_SWAP_AB_BUTTONS:false, F_SWAP_XY_BUTTONS:false, F_GUIDE:false, WINDOWTRANS:table: 0x017d6d4e70 (more...)}
 dt = number: 0.0166533
(15) Lua method 'update' at line 1177 of chunk '"/Users/Jevonn/Library/Application Support/Bal..."]'
Local variables:
 self = table: 0x010ede8680  {F_SWAP_AB_BUTTONS:false, F_SWAP_XY_BUTTONS:false, F_GUIDE:false, WINDOWTRANS:table: 0x017d6d4e70 (more...)}
 dt = number: 0.0166533
(16) Lua field 'update' at file 'main.lua:133'
Local variables:
 dt = number: 0.0166533
(17) Lua function '?' at file 'main.lua:77' (best guess)
(18) global C function 'xpcall'
(19) Love2D function at file 'boot.lua:377' (best guess)
Local variables:
 func = Lua function '?' (defined at line 48 of chunk main.lua)
 inerror = boolean: true
 deferErrhand = Lua function '(Love2D Function)' (defined at line 348 of chunk [love "boot.lua"])
 earlyinit = Lua function '(Love2D Function)' (defined at line 355 of chunk [love "boot.lua"])
