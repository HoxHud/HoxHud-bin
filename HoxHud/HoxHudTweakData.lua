--[[
This is the configuration file for HoxHud. Please be careful editing values as you can cause the game to crash upon loading if a value is made invalid

We recommend colorpicker.com if you want to choose a color to use. The game also has some predefined colors and they are used here purely for brevity.

Only the following Colors are defined explicitly:
Color.red (FF0000), Color.green(00FF00), Color.blue (0000FF), Color.cyan (0000FF), Color.purple(FF00FF), Color.black (000000), Color.white (FFFFFF), Color.yellow (FFFF00)
]]--

--This is a table of custom colours. add your own if you want to use them from the in-game options.
--The nice_name can be filled in here if you're lazy to go do it in HoxHudLocalisation
HoxHudTweakData.CUSTOM_COLORS = {
	{ color = "FF8800", nice_name = nil, name = "orange" },
	{ color = "FFA500", nice_name = nil, name = "light_yellow" },
	{ color = "FC9797", nice_name = nil, name = "pastel_red" },
	{ color = "FCD997", nice_name = nil, name = "pastel_yellow" },
	{ color = "C2FF97", nice_name = nil, name = "pastel_green" },
	{ color = "97FC9A", nice_name = nil, name = "light_green" },
	{ color = "00AAFF", nice_name = nil, name = "light_blue" },
	{ color = "55DDFF", nice_name = nil, name = "baby_blue" },
	{ color = "FF4400", nice_name = nil, name = "orange_red" },
}

--This function is called to process and return the kill counters to display on the HUD, customise as you see fit.
function HoxHudTweakData:format_kills(headshots, bodyshots, sentry_headshots, sentry_total_kills, detailed_counts)
	return string.format("%d/%d (%d)", headshots, bodyshots, headshots + bodyshots)
end

function HoxHudTweakData:press_substitute(text, new)
	return text:gsub(self.local_strings.hoxhud_interact_hold, new == "Press" and self.local_strings.hoxhud_interact_press or self.local_strings.hoxhud_interact_release)
end

function HoxHudTweakData:init()

	self.inspect_url = "http://pd2stats.com/stats.php?profiles=%s#skilldata" --URL to load for inspect player. %s is the variable for the user's 64-bit SteamID

	--these are the extra info boxes that appear in the top right, customise their display behaviour and order as you like.
	self.pagers_info_box =		{ stealth_only = true,  loud_only = false, opt = "hoxhud_pagers_infobox_enable", order = 1 }
	self.alertedcivs_info_box = { stealth_only = true,  loud_only = false, opt = "hoxhud_alrtcivs_infobox_enable", order = 2, hideAtZero = true }
	self.dom_info_box =			{ stealth_only = false, loud_only = false, opt = "hoxhud_dom_infobox_enable", order = 3, hideAtZero = true }
	self.jokers_info_box =		{ stealth_only = false, loud_only = false, opt = "hoxhud_jkr_infobox_enable", order = 4, hideAtZero = true }
	self.bodybags_info_box =	{ stealth_only = true,  loud_only = false, opt = "hoxhud_bdy_infobox_enable", order = 5, hideAtZero = true }
	self.sentry_info_box =		{ stealth_only = false, loud_only = false, opt = "hoxhud_sentry_infobox_enable", order = 6, hideAtZero = true }
	self.feedback_info_box =	{ stealth_only = false, loud_only = false, opt = "hoxhud_ecmfb_infobox_enable", order = 7, hideAtZero = true }
	self.totalenemies_info_box= { stealth_only = false, loud_only = false, opt = "hoxhud_enemy_infobox_enable", order = 8, hideAtZero = true }
	self.lootbags_info_box =	{ stealth_only = false, loud_only = false, opt = "hoxhud_lootbag_infobox_enable", order = 9, hideAtZero = true }
	self.gagemodpack_info_box = { stealth_only = false, loud_only = false, opt = "hoxhud_gage_infobox_enable", order = 10, hideAtZero = true }


	self.phase_map = { build = "build", sustain = "sustain", fade = "fade"}

	self.total_skill_profiles = 5 --Number of profiles to initialize in Skill profiler.
	
	--These values control the damage counter that appears over the head of an enemy when you damage them.
	self.workspace_size = {150, 100} --Canvas size for the in-world workspace in width and height respectively. Recommended not to change this.
	self.text_scaling = 50 --Scaling value for text (size). Recommended not to change this.
	self.text_font_size = 60 --Original font size to use on text object. Recommended not to change this.
	self.flash_offset = { -100, -35 } --Offset as X and Y coords for the flashing displayed on a headshot. Recommended not to change this.
	self.flash_dimensions = { 200, 300 } --Size of the flash object as height and width. Recommended not to change this.
	
	local laser_color = Color.green
	
	--the line below is a table of colours displaying in reverse order (e.g. at 1 revive left, text is FC9797, at 2 revives it's FCD997)
	self.revive_counter_colors = { Color("FC9797"), Color("FCD997"), Color("C2FF97"), Color("97FC9A") }
	--self.revive_counter_colors[0] = Color.purple:with_alpha(0.9) --Uncomment this line if you'd like to set a custom color when you have 0 revives left
	self.damage_boost_flash_speed = 4
	self.health_dampen_flash_speed = 4
	self.infinite_ammo_flash_speed = 4
	
	self.count_untied_civs = false --if false, pacified civilians are not counted in the infobox but will be recounted if they get back up (unpacified).
	
	self.ecm_name = self.local_strings.hoxhud_timer_name_map.ecm --This sets the text to display on the timer for an ECM that has been placed
	self.ecm_feedback_name = self.local_strings.hoxhud_timer_name_map.ecm_feedback -- This sets the text to display on the timer when the ECM is in feedback mode
	self.ecm_feedback_flash = Color.red -- This sets the colour for the timer to flash while feedback is active
	self.ecm_text_color = Color.white -- This sets the colour to display for the ECM text
	self.ecm_expire_color = Color.red -- This sets the colour the timer text will turn as it gets closer to running out
	
	self.sentry_name = self.local_strings.hoxhud_timer_name_map.sentry --This sets the text to display on the "timer" for a Sentry that has been placed
	self.sentry_text_color = Color("29A300") --This sets the colour of the Sentry text
	self.sentry_expire_color = Color.red -- This sets the colour the timer text will turn as it gets closer to running out

	self.pager_name = self.local_strings.hoxhud_timer_name_map.pager
	self.pager_expire_color = Color.red --Color for pager timer to turn as you get closer to running out of time.
	self.pager_text_color = Color.white --Color for pager timer to start at.

	self.cheater_check_disabled = false --disables the Cheater Defeater ingame check if set to true
	self.disable_money_cheat_checker = false --disables the money hack check if set to true
	self.money_cheater_threshold = 8000000 --sets the threshold for triggering the warning dialog that offers to let you reset your money
	self.cheater_color = Color.red --sets the color to change a detected cheater to. Only works if hosting
	self.cheater_secure_limit = { arm_for = 43 } --secured bags threshold for specific missions. Train Heist (arm_for) is 43
	self.cheater_default_secure_limit = 25 --secured bags threshold to check when you're a client
	self.max_player_sentries = 2 --max number of sentries a player should be allowed to place.
	self.max_player_tripmines = 6 --max number of tripmines a player should be allowed to place.
	self.max_player_ecms = 2 --max number of ECMs a player should be allowed to place.
	self.max_deployables = { default = 2, FirstAidKitBase = 14 } --max number of Deployables a player should be allowed to place. (ammo/health)
	self.allow_grenades_in_stealth = true --other players will not be allowed to throw grenades in stealth until you have
	self.disable_interaction_cheat_checks = false --interaction cheat check limits players to 1 interaction every 0.5 seconds.
	self.disable_carry_bag_check = false --prevents players from picking up more than one bag. If they do, drops their bag and disallows them picking up any more.
	--The line below is used for behaviour checks during loot "spawn", don't alter this line unless you know what you're doing.
	self.carry_interactions = { carry_drop = true, corpse_dispose = true, take_weapons = true, steal_methbag = true, hold_pickup_lance = true,
								hold_take_server = true, hold_take_server_axis = true, mus_take_diamond = true, hold_remove_ladder = true, 
								server_give_vehicle_loot_to_player = true, winch_part = true, cas_take_fireworks_bag = true, cas_take_empty_watertank = true, 
								cas_take_full_watertank = true, cas_take_unknown = true, pku_safe = true, safe_carry_drop = true }
	
	self.disable_enhanced_assault_indicator = false --Change to true to disable the enhanced assault indicator that shows when you're hosting a game.
	self.assault_phase_text = self.local_strings.hoxhud_assault_phase_text
	self.assault_spawn_amount_text = self.local_strings.hoxhud_spawn_amount_text
	self.assault_time_left_text = self.local_strings.hoxhud_assault_time_left_text
	self.phase_map = self.local_strings.hoxhud_assault_phase_map
	

	self.sniper_angled_sight_rotation    = { }
	self.sniper_angled_sight_translation = { msr = Vector3(-11, -3, -11), m95 = Vector3(-10.5, -8, -12), r93 = Vector3(-12.5, 7, -11) }
	--self.sniper_angled_sight_rotation = { msr = Rotation(0), m95 = Rotation(0), r93 = Rotation(0) }
	--self.sniper_angled_sight_translation = { msr = Vector3(0,0,0), m95 = Vector3(0,0,0), r93 = Rotation(0) }

	self.decapitation_categories = { shotgun = 1, snp = 1 } -- "high damage" option for decaptations allows all shotguns and snipers
	self.decapitation_weapons = { deagle = 1, ak74 = 1, new_raging_bull = 1, new_m14 = 1 } -- "high damage" option allows these weapons additionally.

	--These values map internal names to readable ones that will display on the HUD timer for that particular thing.
	self.timer_name_map = self.local_strings.hoxhud_timer_name_map
	--Defining a timer item in the table below will result in its timer being placed on the Tab screen instead of the main HUD.
	self.tab_screen_timers = { drill = nil, lance = nil, lance_upgrade = nil, hack_suburbia = nil, uload_database = nil, uload_database_jammed = nil }
	self.timer_text_color = Color.white --Sets the colour of the item's name text
	self.timer_complete_color = Color.green --Sets the colour that the timer text will change to as it gets closer to completion
	self.timer_broken_flash = Color.red --Sets the colour that the timer will flash if the item gets jammed (breaks)
	self.timer_flash_speed = 1 --speed for the text to flash when broken, higher numbers will make it flash faster, you can use a decimal place for higher granularity

	self.drill_autorestart_flash = Color("AA00FF") --Alternative colour to flash if a drill jams but it has Autorestart chance
	self.drill_silent_basic = Color("70E5FF") --Alternative colour for drill text if it has basic silent drilling
	self.drill_silent_aced = Color("003CFF") --Alternative colour for drill text if it has Aced silent drilling
	
	self.tape_loop_name = self.local_strings.hoxhud_timer_name_map.tape_loop
	self.tape_loop_expire_color = Color("700000")
	self.tape_loop_restart_flash_period = 3 --larger numbers = faster flashing
end
