--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local response = false
local localVer = 3.9
local scriptName = "AFK_OP_Money"
local versionCheckInterval = 300000 -- 5 minutos
local updateButtonCreated = false 

--nombre y version
menu.divider(menu.my_root(), scriptName .. " v" .. localVer)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function latiao_server_TRANSACTION(hash, amount)
    SET_INT_GLOBAL(4537311 + 1, 2147483646)
    SET_INT_GLOBAL(4537311 + 7, 2147483647)
    SET_INT_GLOBAL(4537311 + 6, 0)
    SET_INT_GLOBAL(4537311 + 5, 0)
    SET_INT_GLOBAL(4537311 + 3, hash)
    SET_INT_GLOBAL(4537311 + 2, amount)
    SET_INT_GLOBAL(4537311, 2)
end

function latiao_log(message)

    print(message, TOAST_ALL)
end
latiao_log("start")
function latiao_filter_log(message)
    if message ~= last_message then
        print(message, TOAST_ALL)
        last_message = message
    end

end

function int2ip(num)

    local ip = "" --El resultado de la inicialización es una cadena vacía.
    for i = 3, 0, -1 do -- Atravesar 4 bytes
        local b = num % 256 -- Obtener el byte más bajo
        num = math.floor(num / 256) -- Desplazar un byte a la derecha
        ip = b .. "." .. ip -- Empalmar bytes en resultado
    end
    return ip:sub(1, -2) -- Eliminar el último punto y devolver el resultado.
end
-- copy chat gpt

local language_code = {
    [0] = "american (en-US)",
    [1] = "french (fr-FR)",
    [2] = "german (de-DE)",
    [3] = "italian (it-IT)",
    [4] = "spanish (es-ES)",
    [5] = "brazilian (pt-BR)",
    [6] = "polish (pl-PL)",
    [7] = "russian (ru-RU)",
    [8] = "korean (ko-KR)",
    [9] = "chinesetrad (zh-TW)",
    [10] = "japanese (ja-JP)",
    [11] = "mexican (es-MX)",
    [12] = "chinesesimp (zh-CN)"
}

local function ALL_Entities()
    local targets = {}

    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not entities.is_player_ped(ped) then
            table.insert(targets, ped)
        end
    end

    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        table.insert(targets, vehicle)
    end

    for _, object in ipairs(entities.get_all_objects_as_handles()) do
        table.insert(targets, object)
    end

    for _, pickups in ipairs(entities.get_all_pickups_as_handles()) do
        table.insert(targets, pickups)
    end

    return targets
end
local INT_MAX = 2147483647
local INT_MIN = -2147483647

local ALL_script = {"abigail1", "abigail2", "achievement_controller", "activity_creator_prototype_launcher",
                    "act_cinema", "af_intro_t_sandy", "agency_heist1", "agency_heist2", "agency_heist3a",
                    "agency_heist3b", "agency_prep1", "agency_prep2amb", "aicover_test", "ainewengland_test",
                    "altruist_cult", "ambientblimp", "ambient_diving", "ambient_mrsphilips", "ambient_solomon",
                    "ambient_sonar", "ambient_tonya", "ambient_tonyacall", "ambient_tonyacall2", "ambient_tonyacall5",
                    "ambient_ufos", "am_agency_suv", "am_airstrike", "am_ammo_drop", "am_arena_shp", "am_armwrestling",
                    "am_armwrestling_apartment", "am_armybase", "am_backup_heli", "am_beach_washup_cinematic",
                    "am_boat_taxi", "am_bru_box", "am_car_mod_tut", "am_casino_limo", "am_casino_luxury_car",
                    "am_casino_peds", "am_challenges", "am_contact_requests", "am_cp_collection", "am_crate_drop",
                    "am_criminal_damage", "am_darts", "am_darts_apartment", "am_dead_drop", "am_destroy_veh",
                    "am_distract_cops", "am_doors", "am_ferriswheel", "am_gang_call", "am_ga_pickups", "am_heist_int",
                    "am_heli_taxi", "am_hi_plane_land_cinematic", "am_hi_plane_take_off_cinematic", "am_hold_up",
                    "am_hot_property", "am_hot_target", "am_hs4_isd_take_vel", "am_hs4_lsa_land_nimb_arrive",
                    "am_hs4_lsa_land_vel", "am_hs4_lsa_take_vel", "am_hs4_nimb_isd_lsa_leave",
                    "am_hs4_nimb_lsa_isd_arrive", "am_hs4_nimb_lsa_isd_leave", "am_hs4_vel_lsa_isd",
                    "am_hunt_the_beast", "am_imp_exp", "am_island_backup_heli", "am_joyrider", "am_kill_list",
                    "am_king_of_the_castle", "am_launcher", "am_lester_cut", "am_lowrider_int",
                    "am_lsia_take_off_cinematic", "am_luxury_showroom", "am_mission_launch", "am_mp_acid_lab",
                    "am_mp_arcade", "am_mp_arcade_claw_crane", "am_mp_arcade_fortune_teller", "am_mp_arcade_love_meter",
                    "am_mp_arcade_peds", "am_mp_arcade_strength_test", "am_mp_arc_cab_manager", "am_mp_arena_box",
                    "am_mp_arena_garage", "am_mp_armory_aircraft", "am_mp_armory_truck", "am_mp_auto_shop",
                    "am_mp_bail_office", "am_mp_biker_warehouse", "am_mp_boardroom_seating", "am_mp_bunker",
                    "am_mp_business_hub", "am_mp_carwash_launch", "am_mp_car_meet_property", "am_mp_car_meet_sandbox",
                    "am_mp_casino", "am_mp_casino_apartment", "am_mp_casino_nightclub", "am_mp_casino_valet_garage",
                    "am_mp_creator_aircraft", "am_mp_creator_trailer", "am_mp_defunct_base", "am_mp_drone",
                    "am_mp_fixer_hq", "am_mp_garage_control", "am_mp_hacker_truck", "am_mp_hangar",
                    "am_mp_ie_warehouse", "am_mp_island", "am_mp_juggalo_hideout", "am_mp_multistorey_garage",
                    "am_mp_music_studio", "am_mp_nightclub", "am_mp_orbital_cannon", "am_mp_peds", "am_mp_property_ext",
                    "am_mp_property_int", "am_mp_rc_vehicle", "am_mp_salvage_yard", "am_mp_shooting_range",
                    "am_mp_simeon_showroom", "am_mp_smoking_activity", "am_mp_smpl_interior_ext",
                    "am_mp_smpl_interior_int", "am_mp_social_club_garage", "am_mp_solomon_office", "am_mp_submarine",
                    "am_mp_vehicle_organization_menu", "am_mp_vehicle_reward", "am_mp_vehicle_weapon",
                    "am_mp_vinewood_premium_garage", "am_mp_vinewood_premium_modshop", "am_mp_warehouse", "am_mp_yacht",
                    "am_npc_invites", "am_pass_the_parcel", "am_penned_in", "am_penthouse_peds", "am_pi_menu",
                    "am_plane_takedown", "am_prison", "am_prostitute", "am_rollercoaster", "am_rontrevor_cut",
                    "am_taxi", "am_vehicle_spawn", "animal_controller", "apartment_minigame_launcher",
                    "apparcadebusiness", "apparcadebusinesshub", "appavengeroperations", "appbailoffice",
                    "appbikerbusiness", "appbroadcast", "appbunkerbusiness", "appbusinesshub", "appcamera",
                    "appchecklist", "appcontacts", "appcovertops", "appemail", "appextraction", "appfixersecurity",
                    "apphackertruck", "apphs_sleep", "appimportexport", "appinternet", "appjipmp", "appmedia",
                    "appmpbossagency", "appmpemail", "appmpjoblistnew", "apporganiser", "appprogresshub",
                    "apprepeatplay", "appsecurohack", "appsecuroserv", "appsettings", "appsidetask", "appsmuggler",
                    "apptextmessage", "apptrackify", "appvinewoodmenu", "appvlsi", "appzit", "arcade_seating",
                    "arena_box_bench_seats", "arena_carmod", "arena_workshop_seats", "armenian1", "armenian2",
                    "armenian3", "armory_aircraft_carmod", "assassin_bus", "assassin_construction", "assassin_hooker",
                    "assassin_multi", "assassin_rankup", "assassin_valet", "atm_trigger", "audiotest",
                    "autosave_controller", "auto_shop_seating", "bailbond1", "bailbond2", "bailbond3", "bailbond4",
                    "bailbond_launcher", "bail_office_seating", "barry1", "barry2", "barry3", "barry3a", "barry3c",
                    "barry4", "base_carmod", "base_corridor_seats", "base_entrance_seats", "base_heist_seats",
                    "base_lounge_seats", "base_quaters_seats", "base_reception_seats", "basic_creator",
                    "beach_exterior_seating", "benchmark", "bigwheel", "bj", "blackjack", "blimptest",
                    "blip_controller", "bootycallhandler", "bootycall_debug_controller", "buddydeathresponse",
                    "bugstar_mission_export", "buildingsiteambience", "building_controller", "business_battles",
                    "business_battles_defend", "business_battles_sell", "business_hub_carmod",
                    "business_hub_garage_seats", "cablecar", "camera_test", "camhedz_arcade", "cam_coord_sender",
                    "candidate_controller", "carmod_shop", "carsteal1", "carsteal2", "carsteal3", "carsteal4",
                    "carwash1", "carwash2", "car_meet_carmod", "car_meet_exterior_seating", "car_meet_interior_seating",
                    "car_roof_test", "casinoroulette", "casino_bar_seating", "casino_exterior_seating",
                    "casino_interior_seating", "casino_lucky_wheel", "casino_main_lounge_seating",
                    "casino_nightclub_seating", "casino_penthouse_seating", "casino_slots", "celebrations",
                    "celebration_editor", "cellphone_controller", "cellphone_flashhand", "charactergoals",
                    "charanimtest", "cheat_controller", "chinese1", "chinese2", "chop", "clothes_shop_mp",
                    "clothes_shop_sp", "code_controller", "combat_test", "comms_controller",
                    "completionpercentage_controller", "component_checker", "context_controller",
                    "controller_ambientarea", "controller_races", "controller_taxi", "controller_towing",
                    "controller_trafficking", "coordinate_recorder", "country_race", "country_race_controller",
                    "creation_startup", "creator", "custom_config", "cutscenemetrics", "cutscenesamples",
                    "cutscene_test", "darts", "debug", "debug_app_select_screen", "debug_clone_outfit_testing",
                    "debug_launcher", "debug_ped_data", "degenatron_games", "density_test", "dialogue_handler",
                    "director_mode", "docks2asubhandler", "docks_heista", "docks_heistb", "docks_prep1", "docks_prep2b",
                    "docks_setup", "dont_cross_the_line", "dreyfuss1", "drf1", "drf2", "drf3", "drf4", "drf5", "drunk",
                    "drunk_controller", "dynamixtest", "email_controller", "emergencycall", "emergencycalllauncher",
                    "epscars", "epsdesert", "epsilon1", "epsilon2", "epsilon3", "epsilon4", "epsilon5", "epsilon6",
                    "epsilon7", "epsilon8", "epsilontract", "epsrobes", "error_listener", "error_thrower",
                    "event_controller", "exile1", "exile2", "exile3", "exile_city_denial", "extreme1", "extreme2",
                    "extreme3", "extreme4", "fairgroundhub", "fake_interiors", "fameorshame_eps", "fameorshame_eps_1",
                    "fame_or_shame_set", "family1", "family1taxi", "family2", "family3", "family4", "family5",
                    "family6", "family_scene_f0", "family_scene_f1", "family_scene_m", "family_scene_t0",
                    "family_scene_t1", "fanatic1", "fanatic2", "fanatic3", "fbi1", "fbi2", "fbi3", "fbi4", "fbi4_intro",
                    "fbi4_prep1", "fbi4_prep2", "fbi4_prep3", "fbi4_prep3amb", "fbi4_prep4", "fbi4_prep5", "fbi5a",
                    "finalea", "finaleb", "finalec1", "finalec2", "finale_choice", "finale_credits", "finale_endgame",
                    "finale_heist1", "finale_heist2a", "finale_heist2b", "finale_heist2_intro", "finale_heist_prepa",
                    "finale_heist_prepb", "finale_heist_prepc", "finale_heist_prepd", "finale_heist_prepeamb",
                    "finale_intro", "fixer_hq_carmod", "fixer_hq_seating", "fixer_hq_seating_op_floor",
                    "fixer_hq_seating_pq", "floating_help_controller", "flowintrotitle", "flowstartaccept",
                    "flow_autoplay", "flow_controller", "flow_help", "flyunderbridges", "fmmc_contentquicklauncher",
                    "fmmc_launcher", "fmmc_playlist_controller", "fm_bj_race_controler", "fm_capture_creator",
                    "fm_content_acid_lab_sell", "fm_content_acid_lab_setup", "fm_content_acid_lab_source",
                    "fm_content_ammunation", "fm_content_armoured_truck", "fm_content_auto_shop_delivery",
                    "fm_content_bank_shootout", "fm_content_bar_resupply", "fm_content_bicycle_time_trial",
                    "fm_content_bike_shop_delivery", "fm_content_bounty_targets", "fm_content_business_battles",
                    "fm_content_cargo", "fm_content_cerberus", "fm_content_chop_shop_delivery",
                    "fm_content_clubhouse_contracts", "fm_content_club_management", "fm_content_club_odd_jobs",
                    "fm_content_club_source", "fm_content_convoy", "fm_content_crime_scene", "fm_content_daily_bounty",
                    "fm_content_dispatch_work", "fm_content_drug_lab_work", "fm_content_drug_vehicle",
                    "fm_content_export_cargo", "fm_content_ghosthunt", "fm_content_golden_gun", "fm_content_gunrunning",
                    "fm_content_hsw_setup", "fm_content_hsw_time_trial", "fm_content_island_dj",
                    "fm_content_island_heist", "fm_content_metal_detector", "fm_content_movie_props",
                    "fm_content_mp_intro", "fm_content_parachuter", "fm_content_payphone_hit", "fm_content_phantom_car",
                    "fm_content_pizza_delivery", "fm_content_possessed_animals", "fm_content_robbery",
                    "fm_content_security_contract", "fm_content_sightseeing", "fm_content_skydive",
                    "fm_content_slasher", "fm_content_smuggler_ops", "fm_content_smuggler_plane",
                    "fm_content_smuggler_resupply", "fm_content_smuggler_sell", "fm_content_smuggler_trail",
                    "fm_content_source_research", "fm_content_stash_house", "fm_content_taxi_driver", "fm_content_test",
                    "fm_content_tow_truck_work", "fm_content_tuner_robbery", "fm_content_ufo_abduction",
                    "fm_content_vehicle_list", "fm_content_vehrob_arena", "fm_content_vehrob_cargo_ship",
                    "fm_content_vehrob_casino_prize", "fm_content_vehrob_disrupt", "fm_content_vehrob_police",
                    "fm_content_vehrob_prep", "fm_content_vehrob_scoping", "fm_content_vehrob_submarine",
                    "fm_content_vehrob_task", "fm_content_vip_contract_1", "fm_content_xmas_mugger",
                    "fm_content_xmas_truck", "fm_deathmatch_controler", "fm_deathmatch_creator", "fm_hideout_controler",
                    "fm_hold_up_tut", "fm_horde_controler", "fm_impromptu_dm_controler", "fm_intro", "fm_intro_cut_dev",
                    "fm_lts_creator", "fm_maintain_cloud_header_data", "fm_maintain_transition_players", "fm_main_menu",
                    "fm_mission_controller", "fm_mission_controller_2020", "fm_mission_creator", "fm_race_controler",
                    "fm_race_creator", "fm_street_dealer", "fm_survival_controller", "fm_survival_creator",
                    "forsalesigns", "fps_test", "fps_test_mag", "franklin0", "franklin1", "franklin2", "freemode",
                    "freemode_clearglobals", "freemode_creator", "freemode_init", "friendactivity",
                    "friends_controller", "friends_debug_controller", "fullmap_test", "fullmap_test_flow",
                    "game_server_test", "gb_airfreight", "gb_amphibious_assault", "gb_assault", "gb_bank_job",
                    "gb_bellybeast", "gb_biker_bad_deal", "gb_biker_burn_assets", "gb_biker_contraband_defend",
                    "gb_biker_contraband_sell", "gb_biker_contract_killing", "gb_biker_criminal_mischief",
                    "gb_biker_destroy_vans", "gb_biker_driveby_assassin", "gb_biker_free_prisoner", "gb_biker_joust",
                    "gb_biker_last_respects", "gb_biker_race_p2p", "gb_biker_rescue_contact", "gb_biker_rippin_it_up",
                    "gb_biker_safecracker", "gb_biker_search_and_destroy", "gb_biker_shuttle",
                    "gb_biker_stand_your_ground", "gb_biker_steal_bikes", "gb_biker_target_rival",
                    "gb_biker_unload_weapons", "gb_biker_wheelie_rider", "gb_carjacking", "gb_cashing_out", "gb_casino",
                    "gb_casino_heist", "gb_casino_heist_planning", "gb_collect_money", "gb_contraband_buy",
                    "gb_contraband_defend", "gb_contraband_sell", "gb_data_hack", "gb_deathmatch", "gb_delivery",
                    "gb_finderskeepers", "gb_fivestar", "gb_fortified", "gb_fragile_goods", "gb_fully_loaded",
                    "gb_gangops", "gb_gang_ops_planning", "gb_gunrunning", "gb_gunrunning_defend",
                    "gb_gunrunning_delivery", "gb_headhunter", "gb_hunt_the_boss", "gb_ie_delivery_cutscene",
                    "gb_illicit_goods_resupply", "gb_infiltration", "gb_jewel_store_grab", "gb_ploughed",
                    "gb_point_to_point", "gb_ramped_up", "gb_rob_shop", "gb_salvage", "gb_security_van", "gb_sightseer",
                    "gb_smuggler", "gb_stockpiling", "gb_target_pursuit", "gb_terminate", "gb_transporter",
                    "gb_vehicle_export", "gb_velocity", "gb_yacht_rob", "general_test", "ggsm_arcade",
                    "globals_fmmcstruct2_registration", "globals_fmmc_struct_registration", "golf", "golf_ai_foursome",
                    "golf_ai_foursome_putting", "golf_mp", "gpb_andymoon", "gpb_baygor", "gpb_billbinder",
                    "gpb_clinton", "gpb_griff", "gpb_jane", "gpb_jerome", "gpb_jesse", "gpb_mani", "gpb_mime",
                    "gpb_pameladrake", "gpb_superhero", "gpb_tonya", "gpb_zombie", "grid_arcade_cabinet",
                    "gtest_airplane", "gtest_avoidance", "gtest_boat", "gtest_divingfromcar",
                    "gtest_divingfromcarwhilefleeing", "gtest_helicopter", "gtest_nearlymissedbycar", "gunclub_shop",
                    "gunfighttest", "gunslinger_arcade", "hacker_truck_carmod", "hairdo_shop_mp", "hairdo_shop_sp",
                    "hangar_carmod", "hao1", "headertest", "heatmap_test", "heatmap_test_flow", "heist_ctrl_agency",
                    "heist_ctrl_docks", "heist_ctrl_finale", "heist_ctrl_jewel", "heist_ctrl_rural",
                    "heist_island_planning", "heli_gun", "heli_streaming", "hud_creator", "hunting1", "hunting2",
                    "hunting_ambient", "idlewarper", "ingamehud", "initial", "item_ownership_output", "jewelry_heist",
                    "jewelry_prep1a", "jewelry_prep1b", "jewelry_prep2a", "jewelry_setup1", "josh1", "josh2", "josh3",
                    "josh4", "juggalo_hideout_carmod", "juggalo_hideout_seating", "lamar1", "landing_pre_startup",
                    "laptop_trigger", "launcher_abigail", "launcher_barry", "launcher_basejumpheli",
                    "launcher_basejumppack", "launcher_carwash", "launcher_darts", "launcher_dreyfuss",
                    "launcher_epsilon", "launcher_extreme", "launcher_fanatic", "launcher_golf", "launcher_hao",
                    "launcher_hunting", "launcher_hunting_ambient", "launcher_josh", "launcher_maude",
                    "launcher_minute", "launcher_mrsphilips", "launcher_nigel", "launcher_offroadracing",
                    "launcher_omega", "launcher_paparazzo", "launcher_pilotschool", "launcher_racing",
                    "launcher_rampage", "launcher_range", "launcher_stunts", "launcher_tennis", "launcher_thelastone",
                    "launcher_tonya", "launcher_triathlon", "launcher_yoga", "lester1", "lesterhandler", "letterscraps",
                    "line_activation_test", "liverecorder", "localpopulator", "locates_tester", "luxe_veh_activity",
                    "magdemo", "magdemo2", "main", "maintransition", "main_install", "main_persistent", "martin1",
                    "maude1", "maude_postbailbond", "me_amanda1", "me_jimmy1", "me_tracey1", "mg_race_to_point",
                    "michael1", "michael2", "michael3", "michael4", "michael4leadout", "minigame_ending_stinger",
                    "minigame_stats_tracker", "minute1", "minute2", "minute3", "missioniaaturret", "mission_race",
                    "mission_repeat_controller", "mission_stat_alerter", "mission_stat_watcher", "mission_triggerer_a",
                    "mission_triggerer_b", "mission_triggerer_c", "mission_triggerer_d", "mmmm", "mpstatsinit",
                    "mptestbed", "mp_awards", "mp_bed_high", "mp_fm_registration", "mp_gameplay_menu", "mp_menuped",
                    "mp_player_damage_numbers", "mp_prop_global_block", "mp_prop_special_global_block",
                    "mp_registration", "mp_save_game_global_block", "mp_skycam_stuck_wiggler", "mp_unlocks",
                    "mp_weapons", "mrsphilips1", "mrsphilips2", "multistorey_garage_ext_seating",
                    "multistorey_garage_seating", "murdermystery", "music_studio_seating",
                    "music_studio_seating_external", "music_studio_smoking", "navmeshtest", "net_activity_creator_ui",
                    "net_apartment_activity", "net_apartment_activity_light", "net_bot_brain", "net_bot_simplebrain",
                    "net_cloud_mission_loader", "net_combat_soaktest", "net_freemode_debug_2023",
                    "net_freemode_debug_stat_2023", "net_jacking_soaktest", "net_rank_tunable_loader",
                    "net_session_soaktest", "net_test_drive", "net_tunable_check", "nigel1", "nigel1a", "nigel1b",
                    "nigel1c", "nigel1d", "nigel2", "nigel3", "nightclubpeds", "nightclub_ground_floor_seats",
                    "nightclub_office_seats", "nightclub_vip_seats", "nodemenututorial", "nodeviewer", "ob_abatdoor",
                    "ob_abattoircut", "ob_airdancer", "ob_bong", "ob_cashregister", "ob_drinking_shots",
                    "ob_foundry_cauldron", "ob_franklin_beer", "ob_franklin_tv", "ob_franklin_wine", "ob_huffing_gas",
                    "ob_jukebox", "ob_mp_bed_high", "ob_mp_bed_low", "ob_mp_bed_med", "ob_mp_shower_med",
                    "ob_mp_stripper", "ob_mr_raspberry_jam", "ob_poledancer", "ob_sofa_franklin", "ob_sofa_michael",
                    "ob_telescope", "ob_tv", "ob_vend1", "ob_vend2", "ob_wheatgrass", "offroad_races", "omega1",
                    "omega2", "paparazzo1", "paparazzo2", "paparazzo3", "paparazzo3a", "paparazzo3b", "paparazzo4",
                    "paradise", "paradise2", "pausemenu", "pausemenucareerhublaunch", "pausemenu_example",
                    "pausemenu_map", "pausemenu_multiplayer", "pausemenu_sp_repeat", "pb_busker", "pb_homeless",
                    "pb_preacher", "pb_prostitute", "personal_carmod_shop", "photographymonkey", "photographywildlife",
                    "physics_perf_test", "physics_perf_test_launcher", "pickuptest", "pickupvehicles",
                    "pickup_controller", "pilot_school", "pilot_school_mp", "pi_menu", "placeholdermission",
                    "placementtest", "planewarptest", "player_controller", "player_controller_b",
                    "player_scene_ft_franklin1", "player_scene_f_lamgraff", "player_scene_f_lamtaunt",
                    "player_scene_f_taxi", "player_scene_mf_traffic", "player_scene_m_cinema", "player_scene_m_fbi2",
                    "player_scene_m_kids", "player_scene_m_shopping", "player_scene_t_bbfight",
                    "player_scene_t_chasecar", "player_scene_t_insult", "player_scene_t_park", "player_scene_t_tie",
                    "player_timetable_scene", "playthrough_builder", "pm_defend", "pm_delivery", "pm_gang_attack",
                    "pm_plane_promotion", "pm_recover_stolen", "postkilled_bailbond2", "postrc_barry1and2",
                    "postrc_barry4", "postrc_epsilon4", "postrc_nigel3", "profiler_registration", "prologue1",
                    "prop_drop", "public_mission_creator", "puzzle", "racetest", "rampage1", "rampage2", "rampage3",
                    "rampage4", "rampage5", "rampage_controller", "randomchar_controller", "range_modern",
                    "range_modern_mp", "rcpdata", "replay_controller", "rerecord_recording", "respawn_controller",
                    "restrictedareas", "re_abandonedcar", "re_accident", "re_armybase", "re_arrests", "re_atmrobbery",
                    "re_bikethief", "re_border", "re_burials", "re_bus_tours", "re_cartheft", "re_chasethieves",
                    "re_crashrescue", "re_cultshootout", "re_dealgonewrong", "re_domestic", "re_drunkdriver", "re_duel",
                    "re_gangfight", "re_gang_intimidation", "re_getaway_driver", "re_hitch_lift",
                    "re_homeland_security", "re_lossantosintl", "re_lured", "re_monkey", "re_mountdance", "re_muggings",
                    "re_paparazzi", "re_prison", "re_prisonerlift", "re_prisonvanbreak", "re_rescuehostage",
                    "re_seaplane", "re_securityvan", "re_shoprobbery", "re_snatched", "re_stag_do", "re_yetarian",
                    "rng_output", "road_arcade", "rollercoaster", "rural_bank_heist", "rural_bank_prep1",
                    "rural_bank_setup", "salvage_yard_seating", "savegame_bed", "save_anywhere", "scaleformgraphictest",
                    "scaleformminigametest", "scaleformprofiling", "scaleformtest", "scene_builder",
                    "sclub_front_bouncer", "scripted_cam_editor", "scriptplayground", "scripttest1", "scripttest2",
                    "scripttest3", "scripttest4", "script_metrics", "scroll_arcade_cabinet", "sctv",
                    "sc_lb_global_block", "selector", "selector_example", "selling_short_1", "selling_short_2",
                    "shooting_camera", "shoprobberies", "shop_controller", "shot_bikejump", "shrinkletter",
                    "sh_intro_f_hills", "sh_intro_m_home", "simeon_showroom_seating", "smoketest", "social_controller",
                    "solomon1", "solomon2", "solomon3", "spaceshipparts", "spawn_activities", "speech_reverb_tracker",
                    "spmc_instancer", "spmc_preloader", "sp_dlc_registration", "sp_editor_mission_instance",
                    "sp_menuped", "sp_pilotschool_reg", "standard_global_init", "standard_global_reg", "startup",
                    "startup_install", "startup_locationtest", "startup_positioning", "startup_smoketest",
                    "stats_controller", "stock_controller", "streaming", "stripclub", "stripclub_drinking",
                    "stripclub_mp", "stripperhome", "stunt_plane_races", "tasklist_1", "tattoo_shop", "taxilauncher",
                    "taxiservice", "taxitutorial", "taxi_clowncar", "taxi_cutyouin", "taxi_deadline", "taxi_followcar",
                    "taxi_gotyounow", "taxi_gotyourback", "taxi_needexcitement", "taxi_procedural", "taxi_takeiteasy",
                    "taxi_taketobest", "tempalpha", "temptest", "tennis", "tennis_ambient", "tennis_family",
                    "tennis_network_mp", "test_startup", "thelastone", "three_card_poker", "timershud",
                    "title_update_registration", "title_update_registration_2", "tonya1", "tonya2", "tonya3", "tonya4",
                    "tonya5", "towing", "traffickingsettings", "traffickingteleport", "traffick_air", "traffick_ground",
                    "train_create_widget", "train_tester", "trevor1", "trevor2", "trevor3", "trevor4", "triathlonsp",
                    "tunables_registration", "tuneables_processing", "tuner_planning", "tuner_property_carmod",
                    "tuner_sandbox_activity", "turret_cam_script", "ufo", "ugc_global_registration",
                    "ugc_global_registration_2", "underwaterpickups", "utvc", "vehiclespawning", "vehicle_ai_test",
                    "vehicle_force_widget", "vehicle_gen_controller", "vehicle_plate", "vehicle_stealth_mode",
                    "vehrob_planning", "veh_play_widget", "vinewood_premium_garage_carmod", "walking_ped",
                    "wardrobe_mp", "wardrobe_sp", "weapon_audio_widget", "wizard_arcade", "wp_partyboombox",
                    "xml_menus", "yoga"}

function ADD_MP_INDEX(stat)
    local Exceptions = {"MP_CHAR_STAT_RALLY_ANIM", "MP_CHAR_ARMOUR_1_COUNT", "MP_CHAR_ARMOUR_2_COUNT",
                        "MP_CHAR_ARMOUR_3_COUNT", "MP_CHAR_ARMOUR_4_COUNT", "MP_CHAR_ARMOUR_5_COUNT"}
    for _, exception in pairs(Exceptions) do
        if stat == exception then
            return "MP" .. util.get_char_slot() .. "_" .. stat
        end
    end

    if not string.contains(stat, "MP_") and not string.contains(stat, "MPPLY_") then
        return "MP" .. util.get_char_slot() .. "_" .. stat
    end
    return stat
end

function STAT_SET_INT(stat, value)
    STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

function STAT_SET_BOOL(stat, value)
    STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

function STAT_SET_STRING(stat, value)
    STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

function STAT_SET_DATE(stat, year, month, day, hour, min)
    local DatePTR = memory.alloc(8 * 7) 
    memory.write_int(DatePTR, year)
    memory.write_int(DatePTR + 8, month)
    memory.write_int(DatePTR + 16, day)
    memory.write_int(DatePTR + 24, hour)
    memory.write_int(DatePTR + 32, min)
    memory.write_int(DatePTR + 40, 0) 
    memory.write_int(DatePTR + 48, 0) 
    STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(stat)), DatePTR, 7, true)
end

function STAT_SET_MASKED_INT(stat, value1, value2)
    STATS.STAT_SET_MASKED_INT(util.joaat(ADD_MP_INDEX(stat)), value1, value2, 8, true)
end

function SET_PACKED_STAT_BOOL_CODE(stat, value)
    STATS.SET_PACKED_STAT_BOOL_CODE(stat, value, util.get_char_slot())
end

function STAT_INCREMENT(stat, value)
    STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(stat)), value, true)
end

function STAT_GET_INT(stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end

function STAT_GET_FLOAT(stat)
    local FloatPTR = memory.alloc_int()
    STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(stat)), FloatPTR, -1)
    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end

function STAT_GET_BOOL(stat)
    if STAT_GET_INT(stat) ~= 0 then
        return "true"
    else
        return "false"
    end
end

function STAT_GET_STRING(stat)
    return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(stat)), -1)
end

function STAT_GET_DATE(stat, type)
    local DatePTR = memory.alloc(8 * 7)
    STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(stat)), DatePTR, 7, true)
    local DateTypes = {"Years", "Months", "Days", "Hours", "Mins" -- Seconds,
    -- Milliseconds,
    }
    for i = 1, #DateTypes do
        if type == DateTypes[i] then
            return memory.read_int(DatePTR + 8 * (i - 1))
        end
    end
end

function SET_INT_GLOBAL(global, value)
    memory.write_int(memory.script_global(global), value)
end

function SET_FLOAT_GLOBAL(global, value)
    memory.write_float(memory.script_global(global), value)
end

function GET_INT_GLOBAL(global)
    return memory.read_int(memory.script_global(global))
end

function SET_PACKED_INT_GLOBAL(start_global, end_global, value)
    for i = start_global, end_global do
        SET_INT_GLOBAL(262145 + i, value)
    end
end

function SET_INT_LOCAL(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_int(memory.script_local(script, script_local), value)
    end
end

function SET_FLOAT_LOCAL(script, script_local, value)
    if memory.script_local(script, script_local) ~= 0 then
        memory.write_float(memory.script_local(script, script_local), value)
    end
end

function GET_INT_LOCAL(script, script_local)
    if memory.script_local(script, script_local) ~= 0 then
        local ReadLocal = memory.read_int(memory.script_local(script, script_local))
        if ReadLocal ~= nil then
            return ReadLocal
        end
    end
end

function SET_BIT(bits, place) 
    return (bits | (1 << place))
end

function SET_LOCAL_BIT(script, script_local, bit)
    if memory.script_local(script, script_local) ~= 0 then
        local Addr = memory.script_local(script, script_local)
        memory.write_int(Addr, SET_BIT(memory.read_int(Addr), bit))
    end
end

util.require_natives("3095a")


local servermoney = menu.list(menu.my_root(), "transacción del servidor", {}, "")


servermoney:toggle_loop("Bloquear Errores de Transacción", {}, "", function()
    if not util.is_session_started() then return end
    if GET_INT_GLOBAL(4537461) == 4 or 20 then
        SET_INT_GLOBAL(4537455, 0)
    end
end)
-- menu.action(test,"entities.player_info_get_game_state",{""},"",function()
--     for k, pid in pairs(players(false,true,true)) do
--         local playersped = players.get

--     end

-- end

-- )

menu.divider(servermoney, "Opciones AFK")


menu.toggle_loop(servermoney, "3.600.000 [AFK]", {""}, "Tiempo de espera de 20 minutos",
    function()
        latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_CASINO_HEIST_FINALE"), 3600000)
        util.yield(120000)
    end)

menu.toggle_loop(servermoney, "2.550.000 [AFK] [20 Mins Enfriamento]", {""}, "Tiempo de espera de 20 minutos",
    function()
        latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_ISLAND_HEIST_FINALE"), 2550000)
        util.yield(120000)
    end)

menu.toggle_loop(servermoney, "2.550.000 [AFK] [20 Mins de Enfriamento]", {""}, "Tiempo de espera de 20 minutos", function()
    latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_GANGOPS_FINALE"), 2550000)
    util.yield(120000)
end)

menu.toggle_loop(servermoney, "180k [30M cada 24H]", {""}, "24 horas de espera", function()
    latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_JOBS"), 180000)
end)
menu.toggle_loop(servermoney, "100k-180k [35M cada 24H]", {""}, "tiempo de espera 24H", function()
    latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_JOBS"), math.random(100000, 150000))
end)
menu.toggle_loop(servermoney, "15M [AFK]", {""}, "Tiempo de espera 30 minutos", function()
    latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_JOB_BONUS"), 15000000)
    util.yield(1800000)
end)
menu.toggle_loop(servermoney, "15M [AFK 2]", {""}, "Tiempo de espera 30 minutos", function()
    latiao_server_TRANSACTION(util.joaat("SERVICE_EARN_BEND_JOB"), 15000000)
    util.yield(1800000)
end)

-- mejor script de recuperación no detectado

util.require_natives(1663599433)
util.toast("Es hora de conseguir esa bolsa")
local tweaks_root = menu.list(menu.my_root(), "Recuperación de dinero", {}, "el plan de dios")
money_delay = 3000
menu.slider(tweaks_root, "Demora", {}, "retraso de dinero", 0, 10000, 100, 1, function(s)
    money_delay = s
end)
money_amt = 30000000
menu.slider(tweaks_root, "Cantidad", {}, "cantidad de dinero", 0, 100000000000, 30000000, 1, function(s)
    money_amt = s
end)
money_random = true
menu.toggle(tweaks_root, "Aleatorio", {}, "Cantidad de dinero aleatoria", function(on)
    money_random = on
end, true)
menu.toggle_loop(tweaks_root, "Habilitar (no detectado)", {}, "Hazte rico", function(on)
    local amt
    if money_random then 
        amt = math.random(100000000, 300000000)
    else
        amt = money_amt
    end
    HUD.CHANGE_FAKE_MP_CASH(0, amt)
    util.yield(money_delay)
end)










--_______________________________________________________________________________________--

  ----------------------------------- 𝚓𝚊𝚟𝚒𝚎𝚛𝚝𝚘𝚛𝚛𝚎𝚜 ---------------------------------
--_________________________________________________________________________________________--


-- local response = false
-- local localVer = 3.3
-- local scriptName = "AFK_OP_Money"
-- local versionCheckInterval = 300000 -- 5 minutos
-- local updateButtonCreated = false 

--noti de version y activar acceso a internet
util.toast("Versión: " .. localVer)
if not async_http.have_access() then
    util.toast("Para utilizar el script desactiva la casilla 'Desactivar acceso a internet'", TOAST_ALL)
    util.stop_script()
end

--verificar la versión disponible
local function checkForUpdates()
    async_http.init("raw.githubusercontent.com", "/j-11-t/OP_Money/main/AKF_OP_Money_Version.lua", function(output)
        local currentVer = tonumber(output)
        if currentVer and localVer ~= currentVer then
            -- Muestra nueva version disponible
            util.toast("[" .. scriptName .. "] Hay una actualización disponible: v" .. currentVer .. " Actualiza lo más pronto posible :D")
            if not updateButtonCreated then
                menu.action(menu.my_root(), "Actualizar Lua", {}, "", function()
                    -- Verifica antes de descargar
                    async_http.init("raw.githubusercontent.com", "/j-11-t/OP_Money/main/AKF_OP_Money_Version.lua", function(newVersionOutput)
                        local latestVer = tonumber(newVersionOutput)
                        if latestVer and localVer ~= latestVer then
                            -- Descarga la nueva version
                            async_http.init('raw.githubusercontent.com', '/j-11-t/OP_Money/main/AFK_OP_Money.lua', function(a)
                                if not a or a == "" then
                                    util.toast("Hubo un fallo al descargar el script. Por favor, actualiza manualmente desde GitHub.")
                                    return
                                end
                                
                                -- guardado y noti de version
                                local filePath = filesystem.scripts_dir() .. SCRIPT_RELPATH
                                local f = io.open(filePath, "wb")
                                if f then
                                    f:write(a)
                                    f:close()
                                    util.toast("Script actualizado a v" .. latestVer .. " Excelente :D")
                                    util.restart_script()
                                else
                                    util.toast("Error al guardar el script. Por favor, actualiza manualmente.")
                                end
                            end)
                            async_http.dispatch()
                        else
                            util.toast("No se encontró una versión más reciente.")
                        end
                    end, function() 
                        util.toast("Error al verificar la versión antes de la descarga.")
                    end)
                    async_http.dispatch()
                end)
                updateButtonCreated = true
            end
        else
        end
    end, function() 
        util.toast("Error al verificar la versión.")
    end)
    async_http.dispatch()
end

--KillSwitch
local function checkKillSwitch()
    async_http.init("raw.githubusercontent.com", "/j-11-t/OP_Money/main/Kill_Switch.lua", function(output)
        local currentKs = tostring(output)
        if currentKs == "true" then
            util.toast("[" .. scriptName .. "] Script desactivado por seguridad :D")
            util.yield(500)
            util.stop_script()
        end
    end, function()
        util.toast("Error al verificar el KillSwitch.")
    end)
    async_http.dispatch()
end

--actualizaciones y KillSwitch en segundo plano
util.create_thread(function()
    while true do
        checkForUpdates()
        checkKillSwitch()
        util.yield(versionCheckInterval)
    end
end)


-- script info
local scriptInfoMenu = menu.list(menu.my_root(), "Acerca de AFK_OP_Money", {}, "Información y opciones sobre el script.")

-- nombre y version
menu.divider(scriptInfoMenu, "AFK_OP_Money")
menu.readonly(scriptInfoMenu, "Versión", localVer)

-- verificar actualizaciones manual
menu.action(scriptInfoMenu, "Buscar Actualización", {}, "El script verificará automáticamente actualizaciones cada 5 minutos, pero puedes hacerlo manualmente con esta opción.", function()
    async_http.init("raw.githubusercontent.com", "/j-11-t/OP_Money/main/AKF_OP_Money_Version.lua", function(output)
        local currentVer = tonumber(output)
        if currentVer and localVer ~= currentVer then
            util.toast("[" .. scriptName .. "] Hay una actualización disponible: v" .. currentVer .. ". Actualiza lo más pronto posible :D")
        else
            util.toast("[" .. scriptName .. "] Tu script ya está actualizado a v" .. localVer .. ".")
        end
    end, function()
        util.toast("Error al verificar la versión.")
    end)
    async_http.dispatch()
end)

-- Enlaces
menu.hyperlink(scriptInfoMenu, "Código Fuente en GitHub", "https://github.com/j-11-t/AFK_OP_Money", "Ver los archivos fuente en GitHub")
menu.hyperlink(scriptInfoMenu, "Servidor de Discord", "https://discord.gg/tu_enlace_de_discord", "Únete al servidor de Discord")


--seccion creditos
menu.divider(scriptInfoMenu, "Créditos")

--creditos d-brutal
local DBrutal = menu.list(scriptInfoMenu, "D-Brutal", {})
menu.hyperlink(DBrutal, "Youtube", "https://www.youtube.com/@d-brutal")
menu.hyperlink(DBrutal, "Discord", "https://")

--otro integrante
-- menu.action(scriptInfoMenu, "Nombre", {}, "", function()
-- end)



--_______________________________________________________________________________________--

  ----------------------------------- 𝚓𝚊𝚟𝚒𝚎𝚛𝚝𝚘𝚛𝚛𝚎𝚜 ---------------------------------
--_________________________________________________________________________________________--