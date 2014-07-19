--[[
This is the configuration file for HoxHud. Please be careful editing values as you can cause the game to crash upon loading if a value is made invalid

We recommend colorpicker.com if you want to choose a color to use. The game also has some predefined colors and they are used here purely for brevity.

Only the following Colors are defined explicitly:
Color.red (FF0000), Color.green(00FF00), Color.blue (0000FF), Color.cyan (0000FF), Color.purple(FF00FF), Color.black (000000), Color.white (FFFFFF), Color.yellow (FFFF00)
]]--

HoxHudTweakData = class()

--This function is called to process and return the kill counters to display on the HUD, customise as you see fit.
function HoxHudTweakData:format_kills(headshots, bodyshots, sentry_headshots, sentry_total_kills)
	return string.format("%d/%d (%d)", headshots, bodyshots, headshots + bodyshots)
end

function HoxHudTweakData:init()
	Color.orange = Color("FF8800")
	
	self.ANTICHEAT_ONLY = false --SETTING THIS TO TRUE WILL DISABLE ALL HOXHUD ELEMENTS, DO NOT REMOVE CONTENT FROM THIS FILE, JUST SET THIS TO true.
	self.HUD_ONLY = false --SETTING THIS TO TRUE WILL DISABLE ALL ANTICHEAT ELEMENTS, WE ONLY RECOMMEND USING THIS IF YOU HAVE ISSUES WITH THE ANTICHEAT.

	self.inspect_url = "http://pd2stats.com/stats.php?profiles=%s#skilldata" --URL to load for inspect player. %s is the variable for the user's 64-bit SteamID

	--these are the extra info boxes that appear in the top right, customise their display behaviour and order as you like.
	self.pagers_info_box =		{ stealth_only = true,  loud_only = false, hide = false, order = 1 }
	self.alertedcivs_info_box = { stealth_only = true,  loud_only = false, hide = false, order = 2, hideAtZero = true }
	self.dom_info_box =			{ stealth_only = false, loud_only = false, hide = false, order = 3, hideAtZero = true }
	self.jokers_info_box =		{ stealth_only = false, loud_only = false, hide = false, order = 4, hideAtZero = true }
	self.bodybags_info_box =	{ stealth_only = true,  loud_only = false, hide = false, order = 5, hideAtZero = true }
	self.sentry_info_box =		{ stealth_only = false, loud_only = false, hide = false, order = 6, hideAtZero = true }
	self.feedback_info_box =	{ stealth_only = false, loud_only = false, hide = false, order = 7, hideAtZero = true }
	self.gagemodpack_info_box = { stealth_only = false, loud_only = false, hide = false, order = 8, hideAtZero = true }

	self.local_strings = { skillprofiler = "Skill Profiler",
						   skillprofiler_help = "Manage your Skill tree profiles.",
						   skillprofiler_title = "Skill Tree Profiler",
						   skillprofiler_text = "Select what you would like to do with your Skill Tree Profiles.",
						   skillprofiler_op_text = "Select Profile to %s",
						   skillprofiler_del_text = "Are you sure you wish to delete profile %s",
						   respec_warn_text = "WARNING: Loading this profile will cost %s%s. Are you sure you wish to continue?",
						   respec_cheaper_text = "NOTICE: Loading this profile will refund you %s%s. Are you sure you wish to continue?",
						   default_profile_name = "Profile %d",
						   bootup_profile_name = "Bootup Skills",
						   profile_ops = { "Load", "Save", "Add Profile", "Del Profile", "Rename" }, --YOU CAN MODIFY TEXT, BUT DO NOT REORDER.
						   rename_text = "Enter new name for %s",
						   rename_prompt = "Rename>",
						   hud_spending_cash = "SPENDING CASH",
						   hud_cleaner_costs = "CLEANER COSTS",
						   cash_sign = "$",
						   menu_asset_buy_all_assets = "Buy All Assets",
						   menu_asset_buy_all_assets_desc = "Buys all the assets that you are permitted to acquire",
						   inspect_player = "Inspect Player",
						   inspect_player_help = "Opens the PD2Stats webpage for this player in your Steam Overlay.",
						 }

	self.phase_map = { build = "build", sustain = "sustain", fade = "fade"}

	self.total_skill_profiles = 5 --Number of profiles to initialize in Skill profiler.

	--these values control the health ring that appears when you target an NPC
	self.enemy_health_size = 100
	self.enemy_health_vertical_offset = 110 --Change this to 15 if you prefer the old location. -400 to hide it.
	self.enemy_health_horizontal_offset = 0 --Change this to move it left or right from the center. negative values move it left.
	self.enemy_hurt_color = Color.orange --Color for enemy health ring to flash on a non-fatal hit.
	self.enemy_kill_color = Color.red --Color for enemy health ring to flash on a fatal hit.
	self.show_multiplied_enemy_health = true --displays enemy health multiplied by 10 (makes it consistent with weapon stats)
	self.ignore_civilian_health = true
	
	--These values control the damage counter that appears over the head of an enemy when you damage them.
	self.disable_damage_counter = false --Set this to true if you don't want the in-world damage counters.
	self.show_damage_per_hit = false --Set to true if you prefer a separate damage text item for every bullet.
	self.dmg_counter_ignore_civilians = true --Set to false if you want to see the in-world damage counters on civilians.
	self.normal_hit_color = Color.white --Colour to use while the enemy is still alive.
	self.fatal_hit_color = Color("FF8400") --Colour to use when the enemy is killed.
	self.normal_hit_change_per_tick = Vector3(0, 0, 0.1) --Coordinates to add to a normal hit every tick. (the default makes it move upwards slowly)
	self.fatal_hit_change_per_tick = Vector3(0, 0, 0.5) --Coordinates to add to a fatal hit every tick. (the default makes it move upwards at a medium rate)
	self.headshot_kill_flash_color = Color.red --Color to flash behind the counter when killed with a headshot.
	self.hit_display_duration = 3.5 --Time in seconds to display damage counter for.
	self.unit_offset = Vector3(0, 0, 60) --Offset from the enemy's head in X, Y, Z values. Recommended not to change this.
	self.workspace_size = {150, 100} --Canvas size for the in-world workspace in width and height respectively. Recommended not to change this.
	self.text_scaling = 50 --Scaling value for text (size). Recommended not to change this.
	self.text_font_size = 60 --Original font size to use on text object. Recommended not to change this.
	self.flash_offset = { -100, -35 } --Offset as X and Y coords for the flashing displayed on a headshot. Recommended not to change this.
	self.flash_dimensions = { 200, 300 } --Size of the flash object as height and width. Recommended not to change this.
	
	local laser_color = Color.green
	self.weapon_laser_color = { light = laser_color*10, glow = laser_color/5, brush = laser_color:with_alpha(0.05) }
	
	--the line below is a table of colours displaying in reverse order (e.g. at 1 revive left, text is FC9797, at 2 revives it's FCD997)
	self.revive_counter_colors = { Color("FC9797"), Color("FCD997"), Color("C2FF97"), Color("97FC9A") }
	--self.revive_counter_colors[0] = Color.purple:with_alpha(0.9) --Uncomment this line if you'd like to set a custom color when you have 0 revives left
	self.infinite_ammo_glow_color = Color("00AAFF")
	self.health_damage_dampen_glow_color = Color.yellow
	self.basic_damage_boost_glow_color = Color("FFA500")
	self.strong_damage_boost_glow_color = Color.red
	self.damage_boost_flash_speed = 4
	self.health_dampen_flash_speed = 4
	self.infinite_ammo_flash_speed = 4
	
	self.count_untied_civs = false --if false, pacified civilians are not counted in the infobox but will be recounted if they get back up (unpacified).
	
	self.show_interact_circle = false --Set to true if you want to see the interact circle and not just the text countdown
	self.set_name_text_color_to_callsign = true --Set to false if you don't want the player's name text colour changed to match their callsign dot.
	self.disable_interact_timer = false --Set this to true if you want to disable the numeric interaction timer
    self.disable_reload_timer = false -- Set this to true if you want to disable the reload timer
	self.disable_armor_regen_timer = false --Set this to true if you want to disable the armor regen timer
	self.disable_timer_panel = false --Set this to true if you want to disable the panel of running timers (drills, ECMs etc.)
	self.disable_kill_counter = false --Set this to true if you want to disable the kill counter for all players.
	self.disable_press_to_skip_blackscreen = false --Set this to true if you want to hold Enter for a full second in order to skip the blackscreen.
	self.armor_regen_color = Color.white --Color for the armor regen delay timer text.
	self.armor_regen_font_size = 22 --Size of the Armor regen delay timer text.
	
	self.kill_counter_color = Color.orange --This sets the colour of the text for your kill counter
	
	self.ecm_name = "ecm" --This sets the text to display on the timer for an ECM that has been placed
	self.ecm_feedback_name = "feedback" -- This sets the text to display on the timer when the ECM is in feedback mode
	self.ecm_feedback_flash = Color.red -- This sets the colour for the timer to flash while feedback is active
	self.ecm_text_color = Color.white -- This sets the colour to display for the ECM text
	self.ecm_expire_color = Color.red -- This sets the colour the timer text will turn as it gets closer to running out
	
	self.sentry_name = "sentry" --This sets the text to display on the "timer" for a Sentry that has been placed
	self.sentry_text_color = Color("29A300") --This sets the colour of the Sentry text
	self.sentry_expire_color = Color.red -- This sets the colour the timer text will turn as it gets closer to running out

	self.pager_name = "pager"
	self.pager_expire_color = Color.red --Color for pager timer to turn as you get closer to running out of time.
	self.pager_text_color = Color.white --Color for pager timer to start at.
	self.disable_pager_timers_if_client = false --Change to true if you don't want pager timers when you're not hosting.
	self.disable_pager_timers = false --No pager timers at all.
    self.sense_of_humour_bypass = false --Set to true if you're a miserable sod who hates funny easter eggs

	self.cheater_check_disabled = false --disables the Cheater Defeater ingame check if set to true
	self.disable_money_cheat_checker = false --disables the money hack check if set to true
	self.money_cheater_threshold = 5000000 --sets the threshold for triggering the warning dialog that offers to let you reset your money
	self.cheater_color = Color.red --sets the color to change a detected cheater to. Only works if hosting
	self.cheater_secure_limit = { arm_for = 43 } --secured bags threshold for specific missions. Train Heist (arm_for) is 43
	self.cheater_default_secure_limit = 25 --secured bags threshold to check when you're a client
	self.max_player_sentries = 2 --max number of sentries a player should be allowed to place.
	self.max_player_tripmines = 6 --max number of tripmines a player should be allowed to place.
	self.max_player_ecms = 2 --max number of ECMs a player should be allowed to place.
	self.max_deployables = 2 --max number of Deployables a player should be allowed to place. (ammo/health)
	self.allow_grenades_in_stealth = true --other players will not be allowed to throw grenades in stealth until you have
	self.disable_interaction_cheat_checks = false --interaction cheat check limits players to 1 interaction every 0.5 seconds.
	self.disable_carry_bag_check = false --prevents players from picking up more than one bag. If they do, drops their bag and disallows them picking up any more.
	--The line below is used for behaviour checks during loot "spawn", don't alter this line unless you know what you're doing.
	self.carry_interactions = { carry_drop = true, corpse_dispose = true, take_weapons = true, steal_methbag = true, hold_pickup_lance = true, hold_take_server = true }
	
	self.money_cheated_dialog_title = "Uh-oh, Cheated Mission Alert!"
	self.money_cheated_dialog_text = "Looks like you were in a mission with a cheater, would you like to reset your spending to $%s and your offshore to $%s"
	self.dialog_yes = "YES"
	self.dialog_no = "NO"
	
	self.disable_enhanced_assault_indicator = false --Change to true to disable the enhanced assault indicator that shows when you're hosting a game.
	self.assault_phase_text = "Assault Phase: "
	self.assault_spawn_amount_text = "Spawns Left: "
	self.assault_time_left_text = "End Time: "

	self.hit_indicator_start_color = Color.white --Initial color of a hit indicator (thing that shows where you got shot from)
	self.hit_indicator_fade_color = Color.red --Color for the indicator to fade to
	self.hit_indicator_fade_duration = 2.4 --Amount of time for the indicator to remain on-screen
	self.hit_indicator_box_diameter = 384 --Diameter of the box containing the hit indicator circle. Larger numbers will make them rotate around a larger circle.
	
	self.disable_numeric_suspicion = false --Change to true and the numeric detection percentage will be hidden
	self.disable_original_suspicion_indicator = false --Change to true if you don't like the bar and just want the numeric
	self.suspicion_text_min_color = Color("55DDFF") --Color for the text display to be when suspicion is at 0%
	self.suspicion_text_max_color = Color("FF4400") --Color for the text display to be when suspicion is at 100%
	self.suspicion_bg_alpha = 0.5 --Alpha value for the black outline

	--The values below align the sniper rifles to the angled sight (if attached and selected). The original values are commented out below, uncomment them to restore original behaviour.
	self.sniper_angled_sight_rotation    = { }
	self.sniper_angled_sight_translation = { msr = Vector3(-11, -3, -11), m95 = Vector3(-10.5, -8, -12), r93 = Vector3(-12.5, 7, -11) }
	--self.sniper_angled_sight_rotation = { msr = Rotation(0), m95 = Rotation(0), r93 = Rotation(0) }
	--self.sniper_angled_sight_translation = { msr = Vector3(0,0,0), m95 = Vector3(0,0,0), r93 = Rotation(0) }

	--These values map internal names to readable ones that will display on the HUD timer for that particular thing.
	self.timer_name_map = { lance = "thermal drill", lance_upgrade = "thermal drill", 
							uload_database = "upload", uload_database_jammed = "upload",
							votingmachine2 = "vote rigging", hack_suburbia = "hacking",
							digitalgui = "Timelock", drill = "drill", huge_lance = "The Beast" }
	--Defining a timer item in the table below will result in its timer being placed on the Tab screen instead of the main HUD.
	self.tab_screen_timers = { drill = 60, lance = 60, lance_upgrade = 60, hack_suburbia = 60, uload_database = 60, uload_database_jammed = 60 }
	self.timer_text_color = Color.white --Sets the colour of the item's name text
	self.timer_complete_color = Color.green --Sets the colour that the timer text will change to as it gets closer to completion
	self.timer_broken_flash = Color.red --Sets the colour that the timer will flash if the item gets jammed (breaks)
	self.timer_flash_speed = 1 --speed for the text to flash when broken, higher numbers will make it flash faster, you can use a decimal place for higher granularity

	self.drill_autorestart_flash = Color("AA00FF") --Alternative colour to flash if a drill jams but it has Autorestart chance
	self.drill_silent_basic = Color("70E5FF") --Alternative colour for drill text if it has basic silent drilling
	self.drill_silent_aced = Color("003CFF") --Alternative colour for drill text if it has Aced silent drilling
	
	self.tape_loop_name = "tape loop"
	self.tape_loop_expire_color = Color("700000")
	self.tape_loop_restart_flash_period = 3 --larger numbers = faster flashing
end
