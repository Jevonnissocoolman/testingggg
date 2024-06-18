-- This file doesn't need to return anything

--[[
local alias__Card_Character_init = Card_Character.init;
function Card_Character:init(args)
	args.center = G.P_CENTERS.j_merry_andy
	return alias__Card_Character_init(self, args)
end]]

-- Hook into this to roll editions for Joker (tarot)
-- Also roll stamps for jokers
local alias__create_card = create_card;
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local area = area or G.jokers
    local center = G.P_CENTERS.b_red
	
	local card = alias__create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	
	if _type == 'Tarot' and card.config.center.key == 'c_Thac_joker_tarot' then
        local edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante)
        card:set_edition(edition)
        check_for_unlock({type = 'have_edition'})
	end
	
	if _type == 'Joker' and G.GAME.used_vouchers.v_Thac_stamp_savvy and not card.seal then
		local odds = pseudorandom(pseudoseed('joker_seal_odds'))
		if odds < 3/10 then
			card:set_seal(pseudorandom_element(TheAutumnCircus.data.joker_stamps, pseudoseed("joker_seal")))
		end
	end
	
	return card
end

local alias__Card_generate_UIBox_ability_table = Card.generate_UIBox_ability_table;
function Card:generate_UIBox_ability_table()
	local ret = alias__Card_generate_UIBox_ability_table(self)
	
	local key = self.config.center.key
	local center_obj = SMODS.Jokers[key] or SMODS.Tarots[key] or SMODS.Planets[key] or SMODS.Spectrals[key] or SMODS.Vouchers[key] or SMODS.Oddities[key]
	
	if center_obj and center_obj.subtitle then
	
		if ret.name and ret.name ~= true then
			local text = ret.name
			
			for k, v in pairs(text) do
				print(tostring(k).." ---- "..tostring(v))
				if type(v) == 'table' then
					for kk, vv in pairs(v.config) do
						print(tostring(kk).." --- "..tostring(vv))
						if type(vv) == 'table' then
							for w, vvv in pairs(vv) do
								print(tostring(w).." -- "..tostring(vvv))
							end
						end
					end
				end
			end
			
			text[1].config.object.text_offset.y = text[1].config.object.text_offset.y - 14
			ret.name = {{n=G.UIT.R, config={align = "cm"},nodes={
				{n=G.UIT.R, config={align = "cm"}, nodes=text},
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.O, config={object = DynaText({string = center_obj.subtitle, colours = {G.C.WHITE},float = true, shadow = true, offset_y = 0.1, silent = true, spacing = 1, scale = 0.33*0.7})}}
				}}
			}}}
		end
	
	end
	
	return ret
end

-- Extended card api
local alias__Card_update = Card.update;
function Card:update(dt)
	alias__Card_update(self, dt)
	
    if G.STAGE == G.STAGES.RUN then
        local key = self.config.center.key
        local center_obj = SMODS.Jokers[key] or SMODS.Tarots[key] or SMODS.Planets[key] or SMODS.Spectrals[key]
        if center_obj and center_obj.update and type(center_obj.update) == "function" then
            center_obj.update(self, dt)
        end
	end
end

-- Chaos' Stamp's effect
local alias__check_for_unlock = check_for_unlock;
function check_for_unlock(args)
	if args.type == 'round_win' then
		local bonus_jollars = 0
		
		for i=1, #G.jokers.cards do
			local card = G.jokers.cards[i]
			if card:get_seal() == "Chaos" then
				ease_dollars(4)
				card_eval_status_text(card, 'dollars', 4)
				delay(0.2)
				--card:juice_up()
			end
		end
	end
	alias__check_for_unlock(args)
end

-- Mr. Bones' Stamp's effect
local alias__new_round = new_round;
function new_round()
	alias__new_round()
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
			
			local score_mult = 1
			
			for i=1, #G.jokers.cards do
				local card = G.jokers.cards[i]
				if card:get_seal() == "Mrbones" then
					score_mult = score_mult * 0.85
					card:juice_up()
				end
			end
			
			
			G.GAME.blind.chips = math.floor(G.GAME.blind.chips * score_mult)
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
			G.HUD_blind:recalculate() 
			G.hand_text_area.blind_chips:juice_up()
			play_sound('chips2')
			
            return true
            end
        }))
end

-- Stamp Coupon's effect
local alias__Card_set_cost = Card.set_cost;
function Card:set_cost()
	alias__Card_set_cost(self)
	if self.ability.set == 'Joker' and self.cost > 0 and self.seal and G.GAME.used_vouchers.v_Thac_stamp_coupon then
		self.cost = math.max(1, self.cost - 2)
		self.sell_cost = math.max(1, math.floor(self.cost/2)) + (self.ability.extra_value or 0)
		self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
	end
end

-- Extended Seal API
local alias__Card_set_seal = Card.set_seal;
function Card:set_seal(_seal, silent, immediate)
	local prev_seal = self:get_seal()
	local seal_obj
	if prev_seal and prev_seal ~= _seal then
		seal_obj = SMODS.Seals[string.lower(prev_seal).."_seal"]
		if seal_obj and seal_obj.unapply then
			print(prev_seal.." Seal unapply function running now")
			seal_obj.unapply(self)
		end
	end
	seal_obj = nil
	
	local ret = alias__Card_set_seal(self, _seal, silent, immediate)
	
	if _seal and _seal ~= prev_seal then
		seal_obj = SMODS.Seals[string.lower(_seal).."_seal"]
		if seal_obj and seal_obj.apply then
			print(_seal.." Seal apply function running now")
			seal_obj.apply(self)
		end
	end
	
	return ret
end

-- extra perma bonuses
local alias__Card_get_chip_mult = Card.get_chip_mult;
function Card:get_chip_mult()
    if self.debuff then return 0 end
    return alias__Card_get_chip_mult(self) + (self.ability.Thac_perma_bonus_mult or 0)
end

local alias__Card_get_chip_x_mult = Card.get_chip_x_mult;
function Card:get_chip_x_mult()
    if self.debuff then return 0 end
    return alias__Card_get_chip_x_mult(self) * (self.ability.Thac_perma_bonus_x_mult or 1)
end

local alias__Card_get_chip_h_mult = Card.get_chip_h_mult;
function Card:get_chip_h_mult()
    if self.debuff then return 0 end
    return alias__Card_get_chip_h_mult(self) + (self.ability.Thac_perma_bonus_h_mult or 0)
end

local alias__Card_get_chip_h_x_mult = Card.get_chip_h_x_mult;
function Card:get_chip_h_x_mult()
    if self.debuff then return 0 end
    return alias__Card_get_chip_h_x_mult(self) + (self.ability.Thac_perma_bonus_h_x_mult or 0)
end
-- end extra perma bonuses

-- Extended Seal API
local alias__Card_add_to_deck = Card.add_to_deck;
function Card:add_to_deck(from_debuff)
	if (not self.added_to_deck) and G.STAGE == G.STAGES.RUN then
		if self.seal then
			seal_obj = SMODS.Seals[string.lower(self.seal).."_seal"]
			if seal_obj and seal_obj.deck_add then
				print(self.seal.." Seal add to deck function running now")
				seal_obj.deck_add(self)
			end
		end
	end
	return alias__Card_add_to_deck(self, from_debuff)
end

-- Extended Seal API
local alias__Card_remove_from_deck = Card.remove_from_deck;
function Card:remove_from_deck(from_debuff)
	if self.added_to_deck and G.STAGE == G.STAGES.RUN then
		if self.seal then
			seal_obj = SMODS.Seals[string.lower(self.seal).."_seal"]
			if seal_obj and seal_obj.deck_remove then
				print(self.seal.." Seal remove from deck function running now")
				seal_obj.deck_remove(self)
			end
		end
	end
	return alias__Card_remove_from_deck(self, from_debuff)
end

--[[ OH MY GOD IF THIS WORKS YALL ARE COOKED
local trackerCalculateJoker = false

local alias__Card_calculate_joker = Card.calculate_joker;
function Card:calculate_joker(context)
	if self.debuff then return nil end
	local ret = alias__Card_calculate_joker(self, context)
	local ret2 = nil
	if ret and self:get_seal() == "Chaos" and not trackerCalculateJoker and not context.blueprint then
		trackerCalculateJoker = true
		ret2 = self:calculate_joker(context)
		if ret.repetitions then
			ret2.repetitions = ret2.repetitions + ret.repetitions
		elseif context.other_card then
			TheAutumnCircus.func.eval_this(context.other_card, {mult_mod = normalEffect.mult, chip_mod = normalEffect.chips, Xmult_mod = normalEffect.x_mult})
		else
			TheAutumnCircus.func.eval_this(self, ret)
		end
		card_eval_status_text(self, 'jokers', nil, nil, nil, {message=localize('k_again_ex'), card=self})
		trackerCalculateJoker = false
	end
	return ret2 or ret
end--]]

-- overriden for testing
local alias__Game_start_run = Game.start_run;
function Game:start_run(args)
	local ret = alias__Game_start_run(self, args)
	
	if not args.savetext and TheAutumnCircus.config.testing_kit then
		local testing_cards = {
			{"Joker", "j_joker", "Jimbo"},
			{"Joker", "j_odd_todd", "Steven"},
			{"Joker", "j_even_steven", "Todd"},
			{"Joker", "j_chaos", "Chaos"},
			{"Joker", "j_mr_bones", "Mrbones"},
			{"Joker", "j_merry_andy", "Andy"},
		}
		for i=1, #testing_cards do
			local targetarea = G.jokers
			
			local card = create_card(testing_cards[i][1], targetarea, nil, nil, nil, nil, testing_cards[i][2], 'deck')
			card:add_to_deck()
			card:set_seal(testing_cards[i][3])
			targetarea:emplace(card)
		end
		
		G.GAME.used_vouchers['v_Thac_stamp_savvy'] = true
		G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
		Card.apply_to_run(nil, G.P_CENTERS['v_Thac_stamp_savvy'])
		G.GAME.used_vouchers['v_Thac_stamp_coupon'] = true
		G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
		Card.apply_to_run(nil, G.P_CENTERS['v_Thac_stamp_coupon'])
	end
	return ret
end
