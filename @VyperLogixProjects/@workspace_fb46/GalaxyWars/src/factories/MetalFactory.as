package factories {
	import mx.core.FlexGlobals;

	public class MetalFactory extends ResourceFactory {

		/*
		Constructor is not used... 
		*/
		public function MetalFactory():* {
		}
		
		[Bindable]
		public static var name:String = 'metal';
		
		private static var __current_level__:int = -1;
		
		public static function get levels_table_columns():Object {
			return {
				'col1': {'dataField':'level', 'headerText':'Level'},
				'col2': {'dataField':'resources', 'headerText':'Required Resources'},
				'col3': {'dataField':'time', 'headerText':'Build Time'},
				'col4': {'dataField':'production', 'headerText':'Production/Hour'}
			};
		}
		
		public static function get icon():Class {
			return Images.metalBuildingImageClass;
		}
		
		public static function get current_level():int {
			if (__current_level__ < 0) {
				var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
				__current_level__ = app.mySO.data.__metal_resource_level__;
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
			app.mySO.data.__metal_resource_level__ = __current_level__;
			app.mySO.flush();
		}
		
		public static function get current_level_production_rate():Object {
			return level_production_rate_for(current_level);
		}
		
		public static function level_production_rate_for(level:int):Object {
			try {
				var resources:Object = ResourceFactory.current_level_upgraded_resources(level);
				var metal:String = ResourceFactory.metal;
				return {metal:ResourceFactory.resource_value_ceiling(resources[metal])};
			} catch (err:Error) {}
			return null;
		}
		
		public static function get current_volume():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return app.metal_resource_volume;
		}
		
		public static function get current_capacity():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return app.metal_resource_volume_capacity;
		}
		
		public static function get current_capacity_percent():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return (current_volume / current_capacity) * 100.0;
		}
		
		public static function get current_den_capacity():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return app.metal_resource_volume_den_capacity;
		}
		
		public static function get current_den_capacity_percent():Number {
			var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
			return (current_volume / current_den_capacity) * 100.0;
		}
		
		public static function level_upgrade_cost_for(level:int):Object {
			try {
				var app:GalaxyWars = FlexGlobals.topLevelApplication as GalaxyWars;
				var resources:Object = ResourceFactory.current_level_upgrade_resources(level);
				var metal:String = ResourceFactory.metal;
				var crystal:String = ResourceFactory.crystal;
				var metal_value:Number = (app.premium_account && (level == 0) && (app.metal_resource_volume < resources[metal])) ? 0 : ResourceFactory.resource_value_ceiling(resources[metal]);
				var crystal_value:Number = resources[crystal]/4;
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