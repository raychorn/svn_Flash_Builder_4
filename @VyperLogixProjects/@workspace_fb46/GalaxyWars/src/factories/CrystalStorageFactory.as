package factories {
	import com.MathUtils;
	
	import mx.core.FlexGlobals;

	public class CrystalStorageFactory extends ResourceFactory {

		/*
		Constructor is not used... 
		*/
		public function CrystalStorageFactory():* {
		}
		
		[Bindable]
		public static var name:String = 'CrystalStorage';
		
		[Bindable]
		public static var type:String = 'capacity';
		
		private static var __current_level__:int = -1;
		
		public static function get levels_table_columns():Object {
			return {
				'col1': {'dataField':'level', 'headerText':'Level'},
				'col2': {'dataField':'resources', 'headerText':'Required Resources'},
				'col3': {'dataField':'time', 'headerText':'Build Time'},
				'col4': {'dataField':'production', 'headerText':'Capacity'}
			};
		}
		
		public static function get icon():Class {
			return Images.crystalStorageImageClass;
		}
		
		public static function get current_level():int {
			if (__current_level__ < 0) {
				var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
				__current_level__ = app.mySO.data.__crystal_storage_level__;
			}
			return __current_level__;
		}
		
		public static function set current_level(level:int):void {
			if (__current_level__ != level) {
				__current_level__ = level;
			}
		}
		
		public static function next_level():void {
			__current_level__++;
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			app.mySO.data.__crystal_storage_level__ = __current_level__;
			app.mySO.flush();
		}
		
		public static function get current_level_production_rate():Object {
			return level_production_rate_for(current_level);
		}
		
		public static function level_production_rate_for(level:int):Object {
			var resources:* = ResourceFactory.current_level_upgraded_resources(level);
			var capacity:Number = resources[CrystalFactory.name] * 24*7;
			capacity = MathUtils.round_to_nearest_magnitude(capacity);
			try {
				var result:* = {};
				result[ResourceFactory.capacity] = capacity;
				return result; // storage produces capacity...
			} catch (err:Error) {}
			return null;
		}
		
		public static function get current_volume():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return app.crystal_resource_volume;
		}
		
		public static function get current_capacity():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return app.crystal_resource_volume_capacity;
		}
		
		public static function get current_capacity_percent():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return (current_volume / current_capacity) * 100.0;
		}
		
		public static function level_upgrade_cost_for(level:int):Object {
			try {
				var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
				var resources:Object = ResourceFactory.current_level_upgrade_resources(level);
				var metal:String = ResourceFactory.metal;
				var crystal:String = ResourceFactory.crystal;
				var metal_value:Number = ResourceFactory.resource_value_ceiling((resources[metal]/2)*60.0);
				var crystal_value:Number = ResourceFactory.resource_value_ceiling(resources[crystal]*26.0);
				return {
					metal: metal_value,
					crystal: crystal_value
				};
			} catch (err:Error) {}
			return null;
		}
		
		public static function get current_level_upgrade_cost():Object {
			return level_upgrade_cost_for(current_level);
		}
		
		public static function level_upgrade_time_for(level:int):Object {
			return ResourceFactory.current_level_upgrade_time(level);
		}
		
		public static function get current_level_upgrade_time():Number {
			return ResourceFactory.current_level_upgrade_time(current_level);
		}
	}
}