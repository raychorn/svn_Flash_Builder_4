package factories {
	import com.ArrayUtils;
	import com.DebuggerUtils;
	import com.FibonacciGenerator;
	import com.ObjectUtils;
	import com.StringUtils;
	import com.TimeUtils;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	
	import controls.Alert.AlertPopUp;

	public class ResourceFactory {
		private static var __current_level__:int = -1;

		public static const metal:String = 'metal';
		public static const crystal:String = 'crystal';
		public static const deuterium:String = 'deuterium';
		public static const capacity:String = 'capacity';
		
		public static var sort_order:Array = [metal,crystal,deuterium,capacity];
		
		private static var fibUT:FibonacciGenerator;
		private static var fibUR:FibonacciGenerator;
		
		public static function get_factory_class_from_name(name:String):Class {
			var __factories__:Array = [
				AllianceDepotFactory,
				ArmourTechFactory,
				AstrophysicsTechFactory,
				BattleCruiserFactory,
				BattleshipFactory,
				BomberFactory,
				ColonyShipFactory,
				CombustionDriveTechFactory,
				ComputerTechFactory,
				CruiserFactory,
				CrystalFactory,
				CrystalStorageDenFactory,
				CrystalStorageFactory,
				DarkMatterCollectorFactory,
				DarkStarFactory,
				DeathStarFactory,
				DefenseMissilesFactory,
				DestroyerFactory,
				DeuteriumFactory,
				DeuteriumStorageDenFactory,
				DeuteriumStorageFactory,
				EnergyTechFactory,
				EspionageTechFactory,
				FusionFactory,
				GaussCannonFactory,
				GravitonCannonFactory,
				GravitonTechFactory,
				HeavyCargoFactory,
				HeavyFighterFactory,
				HLasersFactory,
				HyperspaceDriveTechFactory,
				HyperspaceTechFactory,
				ImpulseDriveTechFactory,
				IntraGalacticResearchNetworkTechFactory,
				IonCannonFactory,
				IonTechFactory,
				LargeShieldFactory,
				LasersFactory,
				LaserTechFactory,
				LightCargoFactory,
				LightFighterFactory,
				MetalFactory,
				MetalStorageDenFactory,
				MetalStorageFactory,
				MissileSiloFactory,
				NaniteFactory,
				OffenseMissilesFactory,
				OrbitalDefensePlatformFactory,
				PlanetaryShieldFactory,
				PlasmaCannonFactory,
				PlasmaDriveTechFactory,
				RecyclerFactory,
				ResearchLabFactory,
				ResourceFactory,
				RoboticsFactory,
				RocketsFactory,
				ShieldingTechFactory,
				ShipyardFactory,
				SmallShieldFactory,
				SolarFactory,
				SolarSatelliteFactory,
				SpyProbeFactory,
				StarDestroyerFactory,
				StarFreighterFactory,
				StarRecyclerFactory,
				TerraformerFactory,
				WeaponsTechFactory
			];
			var i:int;
			var c:Class;
			var _name:String = name.toLowerCase();
			for (i = 0; i < __factories__.length; i++) {
				c = __factories__[i];
				if ( (c) && (c['name']) && (_name == c['name'].toLowerCase()) ) {
					return c;
				}				
			}
			return null;
		}
		
		public static function normalize_factory_name(name:String):String {
			var toks:Array = [metal,crystal,deuterium];
			var i:int;
			var parts:ArrayCollection;
			var token:String;
			for (i = 0; i < toks.length; i++) {
				token = toks[i].toLowerCase();
				parts = new ArrayCollection(name.toLowerCase().split(token));
				while ( (parts.length) && (parts.source[parts.length-1].length == 0) ) {
					parts.removeItemAt(parts.length-1);
				}
				if (parts.length > 1) {
					parts.setItemAt(token,0);
					return ArrayUtils.iterate_and_clone(parts.source, 
						function (item:*, i:int, source:*):void {
							if (source[i].length == 0) {
								source[i] = StringUtils.capitalize(token);;
							} else {
								source[i] = StringUtils.capitalize(source[i]);
							}
						}
					).join(' ');
				}
			}
			return StringUtils.capitalize(name);
		}
		
		public static function get current_level():int {
			return __current_level__;
		}
		
		public static function set current_level(level:int):void {
			if (__current_level__ != level) {
				__current_level__ = level;
			}
		}
		
		public static function current_level_toString(current_level:int):String {
			return (current_level == 0) ? 'L'+current_level.toString() : 'Level '+current_level.toString();
		}
		
		public static function current_level_upgrade_time(level:Number):Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			try {
				var t:Number = 30;
				var f:int;
				fibUR = new FibonacciGenerator();
				for (var i:int = 1; i <= level; i++) {
					f = fibUR.next();
				}
				app.log = '(@@@) f='+f;
				return (f*60)+t;
			} catch (err:Error) {
				app.log = err.message+', '+err.getStackTrace();
			}
			return -1;
		}

		public static function current_level_upgraded_resources(level:Number,ring:Number=1):Object {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			try {
				var factor:Number = Math.log(level+2) * ring * (level+1);
				var resources:* = current_level_upgrade_resources(level,ring);
				var cost:Object = {
									metal:((resources[metal]/2) * factor),
									crystal:((resources[crystal]/3) * factor),
									deuterium:((resources[deuterium]/4) * factor)
				};
				return cost;
			} catch (err:Error) {
				app.log = err.message+', '+err.getStackTrace();
			}
			return null;
		}
		
		private static function __current_level_upgrade_resources(ring:Number=1):Object {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			try {
				var level:Number = 0;
				var f:int;
				fibUR = new FibonacciGenerator();
				for (var i:int = 1; i <= level; i++) {
					f = fibUR.next();
				}
				var t:Number = current_level_upgrade_time(level);
				var r:Number = Math.abs(Math.sin((level+1)));
				var tr:Number = t*r;
				var __metal__:Number = ((tr*36*ring)/10)/t;
				var __crystal__:Number = ((tr*30*ring)/10)/t;
				var __deuterium__:Number = ((tr*18*ring)/10)/t;
				var cost:Object = {metal:__metal__,crystal:__crystal__,deuterium:__deuterium__};
				return cost;
			} catch (err:Error) {
				app.log = err.message+', '+err.getStackTrace();
			}
			return null;
		}
		
		public static function current_level_upgrade_resources(level:Number,ring:Number=1):Object {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			try {
				var __resources__:* = __current_level_upgrade_resources(ring);
				app.log = '(@@@) level='+level+', ring='+ring;
				var t:Number = current_level_upgrade_time(level);
				var __metal__:Number = __resources__[MetalFactory.name]*t;
				var __crystal__:Number = __resources__[CrystalFactory.name]*t;
				var __deuterium__:Number = __resources__[DeuteriumFactory.name]*t;
				app.log = '(@@@) __metal__='+__metal__+', __crystal__='+__crystal__+', __deuterium__='+__deuterium__;
				var cost:Object = {metal:__metal__,crystal:__crystal__,deuterium:__deuterium__};
				return cost;
			} catch (err:Error) {
				app.log = err.message+', '+err.getStackTrace();
			}
			return null;
		}
		
		public static function levels_table_for_factory(factory:Class,levels:int):Array {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var results:Array = [];
			var level_upgrade_cost_for:Function;
			var level_upgrade_time_for:Function;
			var level_production_rate_for:Function;
			for (var i:int = 0; i < levels; i++) {
				try {
					if (factory['level_upgrade_cost_for'] is Function) {
						level_upgrade_cost_for = factory['level_upgrade_cost_for'];
					}
					if (factory['level_upgrade_time_for'] is Function) {
						level_upgrade_time_for = factory['level_upgrade_time_for'];
					}
					if (factory['level_production_rate_for'] is Function) {
						level_production_rate_for = factory['level_production_rate_for'];
					}
					var obj:* = {
						'level':i+1,
						'resources':current_level_upgrade_cost_as_string(level_upgrade_cost_for(i),false),
						'__resources__':current_level_upgrade_cost_as_string(level_upgrade_cost_for(i),true),
						'time':TimeUtils.convertTime(level_upgrade_time_for(i),true),
						'production':current_level_upgrade_cost_as_string(level_production_rate_for(i))
					};
					app.log = DebuggerUtils.explainThis(obj);
					results.push(obj);
				} catch (err:Error) {
					app.log = err.message+', '+err.getStackTrace();
				}
			}
			return results;
		}
		
		public static function estimate_time_required_for_resource_cost_using(resource:Object):Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var metal_resource_volume:Number = app.metal_resource_volume;
			var metal_rate:Number = app.metal_resource_rate;
			var crystal_resource_volume:Number = app.crystal_resource_volume;
			var crystal_rate:Number = app.crystal_resource_rate;
			var deuterium_resource_volume:Number = app.deuterium_resource_volume;
			var deuterium_rate:Number = app.deuterium_resource_rate;
			var vector:Object = {};
			var secs:Number = 0.0;
			if (resource) {
				app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().1 --> resource['+ResourceFactory.metal+']='+resource[ResourceFactory.metal];
				if (resource[ResourceFactory.metal]) {
					app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().1a --> metal_resource_volume (volume)='+metal_resource_volume;
					if (metal_resource_volume < resource[ResourceFactory.metal]) {
						vector[ResourceFactory.metal] = (resource[ResourceFactory.metal] - metal_resource_volume) / metal_rate;
						secs = Math.max(secs,vector[ResourceFactory.metal]);
						app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().1b --> secs=' + secs + ', vector='+DebuggerUtils.explainThis(vector);
					}
				}
				app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().2 --> resource['+ResourceFactory.crystal+']='+resource[ResourceFactory.crystal];
				if (resource[ResourceFactory.crystal]) {
					app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().2a --> crystal_resource_volume (volume)='+crystal_resource_volume;
					if (crystal_resource_volume < resource[ResourceFactory.crystal]) {
						vector[ResourceFactory.crystal] = (resource[ResourceFactory.crystal] - crystal_resource_volume) / crystal_rate;
						secs = Math.max(secs,vector[ResourceFactory.crystal]);
						app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().2b --> secs=' + secs + ', vector='+DebuggerUtils.explainThis(vector);
					}
				}
				app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().3 --> resource['+ResourceFactory.deuterium+']='+resource[ResourceFactory.deuterium];
				if (resource[ResourceFactory.deuterium]) {
					app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().3a --> deuterium_resource_volume (volume)='+deuterium_resource_volume;
					if (deuterium_resource_volume < resource[ResourceFactory.deuterium]) {
						vector[ResourceFactory.deuterium] = (resource[ResourceFactory.deuterium] - deuterium_resource_volume) / deuterium_rate;
						secs = Math.max(secs,vector[ResourceFactory.deuterium]);
						app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().3b --> secs=' + secs + ', vector='+DebuggerUtils.explainThis(vector);
					}
				}
			} else {
				app.log = DebuggerUtils.getCallingFunctionName(new Error())+' produced an error !!!';
			}
			app.log = '(!!!) ResourceFactory.estimate_time_required_for_resource_cost_using().5 --> vector='+DebuggerUtils.explainThis(vector);
			return secs;
		}
		
		private static function spend_resources_or_check_using(resource:Object,check_only:Boolean=true,refund:Boolean=false):Boolean {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var metal_resource_volume:Number = app.metal_resource_volume;
			var crystal_resource_volume:Number = app.crystal_resource_volume;
			var deuterium_resource_volume:Number = app.deuterium_resource_volume;
			var response:Boolean = false;
			if (resource) {
				app.log = '(!!!) ResourceFactory.has_resources_using().1 response='+response+', resource['+ResourceFactory.metal+']='+resource[ResourceFactory.metal];
				if (resource[ResourceFactory.metal]) {
					response = (resource[ResourceFactory.metal] <= metal_resource_volume);
					app.log = '(!!!) ResourceFactory.has_resources_using().2 response='+response+', metal_resource_volume='+metal_resource_volume;
					if (!check_only) {
						if (refund) {
							app.metal_resource_volume += resource[ResourceFactory.metal];
						} else {
							app.metal_resource_volume -= resource[ResourceFactory.metal];
						}
						app.log = '(!!!) ResourceFactory.has_resources_using().2.1 app.metal_resource_volume='+app.metal_resource_volume;
					}
				}
				app.log = '(!!!) ResourceFactory.has_resources_using().1 response='+response+', resource['+ResourceFactory.metal+']='+resource[ResourceFactory.metal]+', resource['+ResourceFactory.crystal+']='+resource[ResourceFactory.crystal];
				if ( (resource[ResourceFactory.metal]) && (resource[ResourceFactory.crystal]) ) {
					response = response && (resource[ResourceFactory.crystal] <= crystal_resource_volume);
					app.log = '(!!!) ResourceFactory.has_resources_using().3 response='+response;
					if (!check_only) {
						if (refund) {
							app.crystal_resource_volume += resource[ResourceFactory.crystal];
						} else {
							app.crystal_resource_volume -= resource[ResourceFactory.crystal];
						}
						app.log = '(!!!) ResourceFactory.has_resources_using().3.1 app.crystal_resource_volume='+app.crystal_resource_volume;
					}
				}
				app.log = '(!!!) ResourceFactory.has_resources_using().1 response='+response+', resource['+ResourceFactory.metal+']='+resource[ResourceFactory.metal]+', resource['+ResourceFactory.crystal+']='+resource[ResourceFactory.crystal]+', resource['+ResourceFactory.deuterium+']='+resource[ResourceFactory.deuterium];
				if ( (resource[ResourceFactory.metal]) && ((resource[ResourceFactory.crystal])) && (resource[ResourceFactory.deuterium]) ) {
					response = response && (resource[ResourceFactory.deuterium] <= deuterium_resource_volume);
					app.log = '(!!!) ResourceFactory.has_resources_using().4 response='+response;
					if (!check_only) {
						if (refund) {
							app.deuterium_resource_volume += resource[ResourceFactory.deuterium];
						} else {
							app.deuterium_resource_volume -= resource[ResourceFactory.deuterium];
						}
						app.log = '(!!!) ResourceFactory.has_resources_using().4.1 app.deuterium_resource_volume='+app.deuterium_resource_volume;
					}
				}
			} else {
				AlertPopUp.errorNoOkay(DebuggerUtils.getCallingFunctionName(new Error())+' produced an error !!!','ERROR');
			}
			app.log = '(!!!) ResourceFactory.has_resources_using().5 response='+response;
			return response;
		}
		
		public static function has_resources_using(resource:Object):Boolean {
			return spend_resources_or_check_using(resource,true,false);
		}
		
		public static function spend_resources_using(resource:Object):Boolean {
			return spend_resources_or_check_using(resource,false,false);
		}
		
		public static function refund_resources_using(resource:Object):Boolean {
			return spend_resources_or_check_using(resource,false,true);
		}
		
		public static function resource_value_ceiling(value:Number):Number {
			return Math.ceil(value / 5)*5;
		}
		
		public static function current_level_upgrade_cost_as_string(value:Object,verbose:Boolean=false):String {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var i:int;
			var keys:Array = ObjectUtils.keys(value);
			var k:String;
			var key:String;
			var xlate:Object = {};
			for (i = 0; i < keys.length; i++) {
				key = keys[i];
				k = key;
				keys[i] = key.toLowerCase();
				xlate[keys[i]] = k;
			}
			keys = ArrayUtils.cloneAndApplySortOrder(keys,sort_order);
			var values:Array = [];
			for (i = 0; i < keys.length; i++) {
				key = keys[i];
				if (value[xlate[key]] == 0) {
					values.push('NO COST for '+key);
				} else {
					if (verbose) {
						values.push(app.formatter_volume.format(value[xlate[key]])+' '+key);
					} else {
						//values.push(key.substr(0,1)+':'+app.formatter_volume.format(value[xlate[key]]));
						values.push(app.formatter_volume.format(value[xlate[key]])+' '+key.substr(0,1));
					}
				}
			}
			return values.join((verbose) ? ' and ' : ', ');
		}

		public static function promote_factory_to_next_level(factory:Class):void {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			var ii:int = -1;
			try {
				factory['next_level']();
				var resources:* = factory.current_level_production_rate;
				var is_type_of_storage:Boolean = (factory.name.toLowerCase().indexOf('storage') > -1);
				if (resources && ( (resources[factory.name]) || (is_type_of_storage) ) ) {
					if (resources[factory.name]) {
						var volume:Number = resources[factory.name];
						if (factory.name == MetalFactory.name) {
							app.metal_resource_rate = volume/app.ticks_per_hour;
						} else if (factory.name == CrystalFactory.name) {
							app.crystal_resource_rate = volume/app.ticks_per_hour;
						} else if (factory.name == DeuteriumFactory.name) {
							app.deuterium_resource_rate = volume/app.ticks_per_hour;
						}
					} else if ( (is_type_of_storage) && (resources[factory.type]) ) {
						var capacity:Number = resources[factory.type];
						if (factory.name == MetalStorageFactory.name) {
							app.metal_resource_volume_capacity = capacity;
						} else if (factory.name == CrystalStorageFactory.name) {
							app.crystal_resource_volume_capacity = capacity;
						} else if (factory.name == DeuteriumStorageFactory.name) {
							app.deuterium_resource_volume_capacity = capacity;
						} else if (factory.name == MetalStorageDenFactory.name) {
							app.metal_resource_volume_den_capacity = capacity;
						} else if (factory.name == CrystalStorageDenFactory.name) {
							app.crystal_resource_volume_den_capacity = capacity;
						} else if (factory.name == DeuteriumStorageDenFactory.name) {
							app.deuterium_resource_volume_den_capacity = capacity;
						}
					}
				}
			} catch (err:Error) {
				app.log = '(???) promote_factory_to_next_level().1 --> err='+err.getStackTrace();
			}
		}
	}
}