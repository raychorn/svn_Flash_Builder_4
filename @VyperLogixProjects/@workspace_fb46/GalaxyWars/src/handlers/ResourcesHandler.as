package handlers {
	import com.DebuggerUtils;
	import com.GUID;
	import com.StringUtils;
	import com.TimeUtils;
	
	import mx.core.FlexGlobals;
	
	import factories.CrystalFactory;
	import factories.CrystalStorageDenFactory;
	import factories.CrystalStorageFactory;
	import factories.DeuteriumFactory;
	import factories.DeuteriumStorageDenFactory;
	import factories.DeuteriumStorageFactory;
	import factories.MetalFactory;
	import factories.MetalStorageDenFactory;
	import factories.MetalStorageFactory;
	import factories.ResourceFactory;

	public class ResourcesHandler {
		public static function get current_metal_data():* {
			var data:* = {};

			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;

			var m_level:int = MetalFactory.current_level;
			var m_cost:* = MetalFactory.current_level_upgrade_cost;
			var m_enabled:Boolean = ResourceFactory.has_resources_using(m_cost) && (!app.is_building_metal);
			
			data['m_level'] = m_level;
			data['m_cost'] = m_cost;
			data['m_enabled'] = m_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_metal_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_crystal_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var c_level:int = CrystalFactory.current_level;
			var c_cost:* = CrystalFactory.current_level_upgrade_cost;
			var c_enabled:Boolean = ResourceFactory.has_resources_using(c_cost) && (!app.is_building_crystal);
			
			data['c_level'] = c_level;
			data['c_cost'] = c_cost;
			data['c_enabled'] = c_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_crystal_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_deuterium_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var d_level:int = DeuteriumFactory.current_level;
			var d_cost:* = DeuteriumFactory.current_level_upgrade_cost;
			var d_enabled:Boolean = ResourceFactory.has_resources_using(d_cost) && (!app.is_building_deuterium);
			
			data['d_level'] = d_level;
			data['d_cost'] = d_cost;
			data['d_enabled'] = d_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_deuterium_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_metal_storage_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var ms_level:int = MetalStorageFactory.current_level;
			var ms_cost:* = MetalStorageFactory.current_level_upgrade_cost;
			var ms_enabled:Boolean = ResourceFactory.has_resources_using(ms_cost);
			
			data['ms_level'] = ms_level;
			data['ms_cost'] = ms_cost;
			data['ms_enabled'] = ms_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_metal_storage_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_crystal_storage_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var cs_level:int = CrystalStorageFactory.current_level;
			var cs_cost:* = CrystalStorageFactory.current_level_upgrade_cost;
			var cs_enabled:Boolean = ResourceFactory.has_resources_using(cs_cost);
			
			data['cs_level'] = cs_level;
			data['cs_cost'] = cs_cost;
			data['cs_enabled'] = cs_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_crystal_storage_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_deuterium_storage_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var ds_level:int = DeuteriumStorageFactory.current_level;
			var ds_cost:* = DeuteriumStorageFactory.current_level_upgrade_cost;
			var ds_enabled:Boolean = ResourceFactory.has_resources_using(ds_cost);
			
			data['ds_level'] = ds_level;
			data['ds_cost'] = ds_cost;
			data['ds_enabled'] = ds_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_deuterium_storage_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_metal_storage_den_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var md_level:int = MetalStorageDenFactory.current_level;
			var md_cost:* = MetalStorageDenFactory.current_level_upgrade_cost;
			var md_enabled:Boolean = ResourceFactory.has_resources_using(md_cost);
			
			data['md_level'] = md_level;
			data['md_cost'] = md_cost;
			data['md_enabled'] = md_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_metal_storage_den_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get current_crystal_storage_den_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var cd_level:int = CrystalStorageDenFactory.current_level;
			var cd_cost:* = CrystalStorageDenFactory.current_level_upgrade_cost;
			var cd_enabled:Boolean = ResourceFactory.has_resources_using(cd_cost);
			
			data['cd_level'] = cd_level;
			data['cd_cost'] = cd_cost;
			data['cd_enabled'] = cd_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_crystal_storage_den_data.1 --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}

		public static function get current_deuterium_storage_den_data():* {
			var data:* = {};
			
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var dd_level:int = DeuteriumStorageDenFactory.current_level;
			var dd_cost:* = DeuteriumStorageDenFactory.current_level_upgrade_cost;
			var dd_enabled:Boolean = ResourceFactory.has_resources_using(dd_cost);
			
			data['dd_level'] = dd_level;
			data['dd_cost'] = dd_cost;
			data['dd_enabled'] = dd_enabled;
			
			app.log_warning = '(+++) ResourcesHandler.current_deuterium_storage_den_data --> data='+DebuggerUtils.explainThis(data);
			
			return data;
		}
		
		public static function get_building_data_for(factory:Class):* {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var info:String = 'L' + ((factory.current_level + 1) + app.number_of_builds_like(factory));
			var tip:String = 'BUILD ' + ResourceFactory.normalize_factory_name(factory.name) + ' to ' + info;
			var data:* = {
				'time':TimeUtils.convertTime(factory.current_level_upgrade_time,false),
					'cost':factory.current_level_upgrade_cost,
					'factory':factory,
					'parent':null,
					'target':null,
					'aspect':'timer',
					'running':false,
					'uuid':GUID.create(),
					'info':info,
					'tooltip':tip,
					'image':factory.icon
			};
			return data;
		}
		
		private static function handle_resources_for_timer():void {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			var current_metal_data:* = ResourcesHandler.current_metal_data;
			var current_crystal_data:* = ResourcesHandler.current_crystal_data;
			var current_deuterium_data:* = ResourcesHandler.current_deuterium_data;

			if (app.is_mode_testing) {
				// determine when next build will take place...
				var m_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_metal_data['m_cost']);
				var c_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_crystal_data['c_cost']);
				var d_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_deuterium_data['d_cost']);
				var parts:Array = [];
				var secs:Number = -999999;
				var s:String;
				var c:String;
				var expectation:*;
				var has_metal_capacity_available:Boolean = MetalStorageFactory.current_capacity_percent < 90.0;
				var has_crystal_capacity_available:Boolean = CrystalStorageFactory.current_capacity_percent < 90.0;
				var has_deuterium_capacity_available:Boolean = DeuteriumStorageFactory.current_capacity_percent < 90.0;
				app.telemetry = {'has_m_cap':{'value':has_metal_capacity_available,'tooltip':'has_metal_capacity_available'}};
				app.telemetry = {'has_c_cap':{'value':has_crystal_capacity_available,'toltip':'has_crystal_capacity_available'}};
				app.telemetry = {'has_d_cap':{'value':has_deuterium_capacity_available,'tooltip':'has_deuterium_capacity_available'}};
				app.telemetry = {'is_building':{'value':app.is_building_anything,'tooltip':'app.is_building_anything'}};
				app.log_warning = '(@!@).1 ResourcesHandler.handle_resources_for_timer().1 --> !isNaN('+m_secs+')='+!isNaN(m_secs)+', isFinite('+m_secs+')='+isFinite(m_secs)+', !app.is_building_metal='+!app.is_building_metal;
				if ( (!isNaN(m_secs)) && (isFinite(m_secs)) && (!app.is_building_something) && (has_metal_capacity_available) ) {
					secs = Math.max(secs,m_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(m_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_metal_data['m_cost'],false);
					parts.push('metal ' + s + ' [' + c + ']');
					expectation = {'factory':MetalFactory,'time':s,'cost':c,'__cost__':current_metal_data['m_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).2 ResourcesHandler.handle_resources_for_timer().2 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(c_secs)) && (isFinite(c_secs)) && (!app.is_building_something) && (has_crystal_capacity_available) ) {
					secs = Math.max(secs,c_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(c_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_crystal_data['c_cost'],false);
					parts.push('crystal ' + s + ' [' + c + ']');
					expectation = {'factory':CrystalFactory,'time':s,'cost':c,'__cost__':current_crystal_data['c_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).3 ResourcesHandler.handle_resources_for_timer().3 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(d_secs)) && (isFinite(d_secs)) && (!app.is_building_something) && (has_deuterium_capacity_available) ) {
					secs = Math.max(secs,d_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(d_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_deuterium_data['d_cost'],false);
					parts.push('deuterium ' + s + ' [' + c + ']');
					expectation = {'factory':DeuteriumFactory,'time':s,'cost':c,'__cost__':current_deuterium_data['d_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).4 ResourcesHandler.handle_resources_for_timer().4 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if (parts.length > 0) {
					parts[0] = StringUtils.capitalize('next ' + parts[0]);
				}
				if (app.is_building_something) {
					secs = app.current_build_secs_remaining;
					app.log_warning = '(@!@).5 ResourcesHandler.handle_resources_for_timer().5 --> secs='+secs;
				}
				app.log_warning = '(@!@).6 ResourcesHandler.handle_resources_for_timer().6 --> secs='+secs;
				if (secs <= 60) {
					if (app.can_TIME_be_bumped_slower) {
						if (!app.is_performing_delayed_action) {
							app.perform_delayed_action = {'delay':1000,'func':app.choose_prev_TIME};
						}
					}
				} else {
					if (app.can_TIME_be_bumped_faster) {
						if (!app.is_performing_delayed_action) {
							app.perform_delayed_action = {'delay':1000,'func':app.choose_next_TIME};
						}
					}
				}
				parts.push('['+((app.is_building_something) ? 'B' : '')+((app.is_performing_delayed_action) ? 'D' : '')+']');
				var status:String = parts.join(', ');
				if (app.isDebugger || app.premium_account) {
					//app.status = status;
				}
				app.log_warning = status;
				
				app.log_warning = '(@!!).1 ResourcesHandler.handle_resources_for_timer().7 --> app.metal_resource_volume='+app.metal_resource_volume+', app.crystal_resource_volume='+app.crystal_resource_volume+', app.deuterium_resource_volume='+app.deuterium_resource_volume;
				if ((app.can_expected_build_be_realized(MetalFactory)) && (has_metal_capacity_available) ) {
					app.goal = MetalFactory;
					app.log_warning = '(@!!).2 ResourcesHandler.handle_resources_for_timer().8 --> app.metal_resource_volume='+app.metal_resource_volume+', app.crystal_resource_volume='+app.crystal_resource_volume+', app.deuterium_resource_volume='+app.deuterium_resource_volume;
				}
				if ( (app.can_expected_build_be_realized(CrystalFactory)) && (has_crystal_capacity_available) ) {
					app.goal = CrystalFactory;
				}
				if ( (app.can_expected_build_be_realized(DeuteriumFactory)) && (has_deuterium_capacity_available) ) {
					app.goal = DeuteriumFactory;
				}
				
				if (app.num_goals == 0) {
					// ???
				}
				
				var __is_premium__:Boolean = ( (app.premium_account) && (current_metal_data['m_level'] == 0) );
				var metal_building_enabled:Boolean = (__is_premium__) || (current_metal_data['m_enabled']);
				var crystal_building_enabled:Boolean = current_crystal_data['c_enabled'];
				var deuterium_building_enabled:Boolean = current_deuterium_data['d_enabled'];
				
				if ( (metal_building_enabled) && (has_metal_capacity_available) && (!app.is_building_anything) && (app.has_goal(MetalFactory)) ) {
					var metal_building_data:* = get_building_data_for(MetalFactory);
					app.log_warning = 'app.premium_account=' + app.premium_account + ', m_level=' + current_metal_data['m_level'] + ', __is_premium__=' + __is_premium__ + ', m_enabled=' + current_metal_data['m_enabled'] + ', m_cost=' + current_metal_data['m_cost'];
					app.log_warning = 'handle_resources_for_timer() BUILD ' + DebuggerUtils.explainThis(metal_building_data) + ' !';
					app.add_timer = metal_building_data;
				}
				if ( (crystal_building_enabled) && (has_crystal_capacity_available) && (!app.is_building_anything) && (app.has_goal(CrystalFactory)) ) {
					var crystal_building_data:* = get_building_data_for(CrystalFactory);
					app.log_warning = 'handle_resources_for_timer() BUILD ' + DebuggerUtils.explainThis(crystal_building_data) + ' !';
					app.add_timer = crystal_building_data;
				}
				if ( (deuterium_building_enabled) && (has_deuterium_capacity_available) && (!app.is_building_anything) && (app.has_goal(DeuteriumFactory)) ) {
					var deuterium_building_data:* = get_building_data_for(DeuteriumFactory);
					app.log_warning = 'handle_resources_for_timer() BUILD ' + DebuggerUtils.explainThis(deuterium_building_data) + ' !';
					app.add_timer = deuterium_building_data;
				}
			}
		}
		
		private static function handle_storage_for_timer():void {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;

			var current_metal_storage_data:* = ResourcesHandler.current_metal_storage_data;
			var current_crystal_storage_data:* = ResourcesHandler.current_crystal_storage_data;
			var current_deuterium_storage_data:* = ResourcesHandler.current_deuterium_storage_data;
			
			if (app.is_mode_testing) {
				// determine when next build will take place...
				var m_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_metal_storage_data['ms_cost']);
				var c_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_crystal_storage_data['cs_cost']);
				var d_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_deuterium_storage_data['ds_cost']);
				var parts:Array = [];
				var secs:Number = -999999;
				var s:String;
				var c:String;
				var expectation:*;
				var has_metal_capacity_available:Boolean = MetalStorageFactory.current_capacity_percent < 90.0;
				var has_crystal_capacity_available:Boolean = CrystalStorageFactory.current_capacity_percent < 90.0;
				var has_deuterium_capacity_available:Boolean = DeuteriumStorageFactory.current_capacity_percent < 90.0;
				app.telemetry = {'has_m_cap2':{'value':has_metal_capacity_available,'tooltip':'has_metal_capacity_available2'}};
				app.telemetry = {'has_c_cap2':{'value':has_crystal_capacity_available,'tooltip':'has_crystal_capacity_available2'}};
				app.telemetry = {'has_d_cap2':{'value':has_deuterium_capacity_available,'tooltip':'has_deuterium_capacity_available2'}};
				app.log_warning = '(@!@).1 ResourcesHandler.handle_storage_for_timer().1 --> !isNaN('+m_secs+')='+!isNaN(m_secs)+', isFinite('+m_secs+')='+isFinite(m_secs)+', !app.is_building_something='+!app.is_building_something;
				if ( (!isNaN(m_secs)) && (isFinite(m_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,m_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(m_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_metal_storage_data['ms_cost'],false);
					parts.push('metal storage ' + s + ' [' + c + ']');
					expectation = {'factory':MetalStorageFactory,'time':s,'cost':c,'__cost__':current_metal_storage_data['ms_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).2 ResourcesHandler.handle_storage_for_timer().2 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(c_secs)) && (isFinite(c_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,c_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(c_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_crystal_storage_data['cs_cost'],false);
					parts.push('crystal storage ' + s + ' [' + c + ']');
					expectation = {'factory':CrystalStorageFactory,'time':s,'cost':c,'__cost__':current_crystal_storage_data['cs_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).3 ResourcesHandler.handle_storage_for_timer().3 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(d_secs)) && (isFinite(d_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,d_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(d_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_deuterium_storage_data['ds_cost'],false);
					parts.push('deuterium storage ' + s + ' [' + c + ']');
					expectation = {'factory':DeuteriumStorageFactory,'time':s,'cost':c,'__cost__':current_deuterium_storage_data['ds_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).4 ResourcesHandler.handle_storage_for_timer().4 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if (parts.length > 0) {
					parts[0] = StringUtils.capitalize('next ' + parts[0]);
				}
				if (app.is_building_something) {
					secs = app.current_build_secs_remaining;
					app.log_warning = '(@!@).5 ResourcesHandler.handle_storage_for_timer().5 --> secs='+secs;
				}
				app.log_warning = '(@!@).6 ResourcesHandler.handle_storage_for_timer().6 --> secs='+secs;
				parts.push('['+((app.is_building_something) ? 'B' : '')+((app.is_performing_delayed_action) ? 'D' : '')+']');
				var status:String = parts.join(', ');
				if (app.isDebugger || app.premium_account) {
					//app.status = status;
				}
				app.log_warning = status;
				
				if ((app.can_expected_build_be_realized(MetalStorageFactory)) && (!has_metal_capacity_available) && (!app.has_any_goals) ) {
					app.goal = MetalStorageFactory;
				}
				if ( (app.can_expected_build_be_realized(CrystalStorageFactory)) && (!has_crystal_capacity_available) && (!app.has_any_goals) ) {
					app.goal = CrystalStorageFactory;
				}
				if ( (app.can_expected_build_be_realized(DeuteriumStorageFactory)) && (!has_deuterium_capacity_available) && (!app.has_any_goals) ) {
					app.goal = DeuteriumStorageFactory;
				}
				
				if ( (!has_metal_capacity_available) && (!app.is_building_something) && (app.has_goal(MetalStorageFactory)) ) {
					var metal_storage_building_data:* = get_building_data_for(MetalStorageFactory);
					app.add_timer = metal_storage_building_data;
				}
				if ( (!has_crystal_capacity_available) && (!app.is_building_something) && (app.has_goal(CrystalStorageFactory)) ) {
					var crystal_storage_building_data:* = get_building_data_for(CrystalStorageFactory);
					app.add_timer = crystal_storage_building_data;
				}
				if ( (!has_deuterium_capacity_available) && (!app.is_building_something) && (app.has_goal(DeuteriumStorageFactory)) ) {
					var deuterium_storage_building_data:* = get_building_data_for(DeuteriumStorageFactory);
					app.add_timer = deuterium_storage_building_data;
				}
			}
		}
		
		private static function handle_storage_den_for_timer():void {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;

			var current_metal_storage_den_data:* = ResourcesHandler.current_metal_storage_den_data;
			var current_crystal_storage_den_data:* = ResourcesHandler.current_crystal_storage_den_data;
			var current_deuterium_storage_den_data:* = ResourcesHandler.current_deuterium_storage_den_data;
			
			if (app.is_mode_testing) {
				// determine when next build will take place...
				var m_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_metal_storage_den_data['md_cost']);
				var c_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_crystal_storage_den_data['cd_cost']);
				var d_secs:Number = ResourceFactory.estimate_time_required_for_resource_cost_using(current_deuterium_storage_den_data['dd_cost']);
				var parts:Array = [];
				var secs:Number = -999999;
				var s:String;
				var c:String;
				var expectation:*;
				app.log_warning = '(@!@).1 ResourcesHandler.handle_storage_den_for_timer().1 --> !isNaN('+m_secs+')='+!isNaN(m_secs)+', isFinite('+m_secs+')='+isFinite(m_secs)+', !app.is_building_something='+!app.is_building_something;
				if ( (!isNaN(m_secs)) && (isFinite(m_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,m_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(m_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_metal_storage_den_data['md_cost'],false);
					parts.push('metal storage den ' + s + ' [' + c + ']');
					expectation = {'factory':MetalStorageDenFactory,'time':s,'cost':c,'__cost__':current_metal_storage_den_data['md_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).2 ResourcesHandler.handle_storage_den_for_timer().2 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(c_secs)) && (isFinite(c_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,c_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(c_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_crystal_storage_den_data['cd_cost'],false);
					parts.push('crystal storage den ' + s + ' [' + c + ']');
					expectation = {'factory':CrystalStorageDenFactory,'time':s,'cost':c,'__cost__':current_crystal_storage_den_data['cd_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).3 ResourcesHandler.handle_storage_den_for_timer().3 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if ( (!isNaN(d_secs)) && (isFinite(d_secs)) && (!app.is_building_something) ) {
					secs = Math.max(secs,d_secs);
					s = StringUtils.milliseconds_as_time(Math.ceil(d_secs)*1000);
					c = ResourceFactory.current_level_upgrade_cost_as_string(current_deuterium_storage_den_data['dd_cost'],false);
					parts.push('deuterium storage ' + s + ' [' + c + ']');
					expectation = {'factory':DeuteriumStorageDenFactory,'time':s,'cost':c,'__cost__':current_deuterium_storage_den_data['dd_cost']};
					app.expecting_to_build = expectation;
					app.log_warning = '(@!@).4 ResourcesHandler.handle_storage_den_for_timer().4 --> app.expecting_to_build='+DebuggerUtils.explainThis(expectation);
				}
				if (parts.length > 0) {
					parts[0] = StringUtils.capitalize('next ' + parts[0]);
				}
				if (app.is_building_something) {
					secs = app.current_build_secs_remaining;
					app.log_warning = '(@!@).5 ResourcesHandler.handle_storage_den_for_timer().5 --> secs='+secs;
				}
				app.log_warning = '(@!@).6 ResourcesHandler.handle_storage_den_for_timer().6 --> secs='+secs;
				parts.push('['+((app.is_building_something) ? 'B' : '')+((app.is_performing_delayed_action) ? 'D' : '')+']');
				var status:String = parts.join(', ');
				if (app.isDebugger || app.premium_account) {
					//app.status = status;
				}
				app.log_warning = status;
				
				if ( (MetalStorageDenFactory.current_capacity_percent >= 90.0) && !app.is_building_something) {
					var metal_storage_den_building_data:* = get_building_data_for(MetalStorageDenFactory);
					app.add_timer = metal_storage_den_building_data;
				}
				if ( (CrystalStorageDenFactory.current_capacity_percent >= 90.0) && !app.is_building_something) {
					var crystal_storage_den_building_data:* = get_building_data_for(CrystalStorageDenFactory);
					app.add_timer = crystal_storage_den_building_data;
				}
				if ( (DeuteriumStorageDenFactory.current_capacity_percent >= 90.0) && !app.is_building_something) {
					var deuterium_storage_den_building_data:* = get_building_data_for(DeuteriumStorageDenFactory);
					app.add_timer = deuterium_storage_den_building_data;
				}
			}
		}
		
		public static function handle_timer_event(event:*):void {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			
			app.log_warning = '(+++) ResourcesHandler.handle_timer_event.1 !!';
			
			try {
				handle_resources_for_timer();
			} catch (err:Error) {
				app.log_error = '(ERROR.1) ResourcesHandler.handle_timer_event().2-->'+err.message+', '+err.getStackTrace();
			}
			try {
				handle_storage_for_timer();
			} catch (err:Error) {
				app.log_error = '(ERROR.2) ResourcesHandler.handle_timer_event().3-->'+err.message+', '+err.getStackTrace();
			}
			try {
				handle_storage_den_for_timer();
			} catch (err:Error) {
				app.log_error = '(ERROR.3) ResourcesHandler.handle_timer_event().4-->'+err.message+', '+err.getStackTrace();
			}
		}
	}
}