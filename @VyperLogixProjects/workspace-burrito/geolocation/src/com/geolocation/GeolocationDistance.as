package com.geolocation {
	import com.ArrayCollectionUtils;
	import com.DebuggerUtils;
	import com.MathUtils;
	import com.ObjectUtils;
	import com.google.maps.LatLng;
	
	import controls.Alert.AlertAlternative;
	
	import flash.geom.Point;

	/**
	 * 
	 * @author rhorn
	 */
	public class GeolocationDistance {

		/**
		 * 
		 * @default 
		 */
		public static var EARTH_RAD:Number = 6378137.0;  // earth's radius in meters (official geoid datum, not 20,000km / pi)

		/**
		 * 
		 * @default 
		 */
		public static var radmiles:Number = EARTH_RAD*100.0/2.54/12.0/5280.0; // earth's radius in miles

		/**
		 * 
		 * @default 
		 */
		public static var LAT_DELTAS:Object = {
			0.00001 : 3.64,
			0.0001 : 36.4,
			0.001 : 364,
			0.01 : 0.69 * 5280,
			0.1 : 6.9 * 5280,
			1.0 : 68.97 * 5280,
			10.0 : 690.23 * 5280
		};
			
		/**
		 * 
		 * @default 
		 */
		public static var LNG_DELTAS:Object = {
			0.00001 : 2.904,
			0.0001 : 29.04,
			0.001 : 290.4,
			0.01 : 0.55 * 5280,
			0.1 : 5.5 * 5280,
			1.0 : 55.00 * 5280,
			10.0 : 549.76 * 5280
		};
			
		/**
		 * 
		 * @default 
		 */
		public static var UNITS:Object = {
			radians : 'radians', 
			miles : 'miles', 
			mi : 'mi', 
			feet : 'feet', 
			meters : 'meters', 
			m : 'm', 
			km : 'km', 
			degrees : 'degrees', 
			min : 'min' 
		};
		
		/**
		 * 
		 * @default 
		 */
		public static var convertible_units:Array = [
			{label:'feet',func:convert_feet_to_feet},
			{label:'miles',func:convert_miles_to_feet},
			{label:'km',func:convert_km_to_feet},
			{label:'meters',func:convert_m_to_feet},
		];

		private static const feet_per_meter:Number = 3280.8398950131 / 1000;
		
		private static const pi:Number = Math['pi'];
		
		/**
		 * 
		 * @default 
		 */
		public static var multipliers:Object = {
			radians : 1, 
			miles : radmiles, 
			mi : radmiles, 
			feet : radmiles * 5280,
			meters : EARTH_RAD, 
			m : EARTH_RAD, 
			km : EARTH_RAD / 1000, 
			degrees : 360 / (2 * pi), 
			min : 60 * 360 / (2 *pi)
		};
		
		/**
		 * 
		 * @param feet
		 * @return 
		 */
		public static function convert_feet_to_feet(feet:Number):Number {
			return feet;
		}
		
		/**
		 * 
		 * @param miles
		 * @return 
		 */
		public static function convert_miles_to_feet(miles:Number):Number {
			return miles * 5280;
		} 

		/**
		 * 
		 * @param km
		 * @return 
		 */
		public static function convert_km_to_feet(km:Number):Number {
			return km * feet_per_meter * 1000;
		} 
		
		/**
		 * 
		 * @param m
		 * @return 
		 */
		public static function convert_m_to_feet(m:Number):Number {
			return m * feet_per_meter;
		} 
		
		private static function min_or_max_delta_from(source:*,is_min:Boolean=true):Number {
			var keys:Array = ObjectUtils.keys_filtered(source,
				function (value:*):Number {
					return Number(value);
				}
			);
			keys.sort();
			return source[keys[(is_min) ? 0 : keys.length-1]];
		}
		
		private static function max_delta_from(source:*):Number {
			return min_or_max_delta_from(source,false);
		}
		
		private static function min_delta_from(source:*):Number {
			return min_or_max_delta_from(source,true);
		}
		
		/**
		 * 
		 * @return 
		 */
		public static function get max_delta_lat():Number {
			return max_delta_from(LAT_DELTAS);
		}
		
		/**
		 * 
		 * @return 
		 */
		public static function get min_delta_lat():Number {
			return min_delta_from(LAT_DELTAS);
		}
		
		/**
		 * 
		 * @return 
		 */
		public static function get min_delta_lng():Number {
			return min_delta_from(LNG_DELTAS);
		}
		
		/**
		 * 
		 * @return 
		 */
		public static function get max_delta_lng():Number {
			return max_delta_from(LNG_DELTAS);
		}
		
		/**
		 * 
		 * @param value
		 * @param units
		 * @param source
		 * @return 
		 */
		public static function delta_from_units_lat_or_lng(value:Number,units:String,source:*):Number {
			var result:Number = value;
			try {
				var i:int = ArrayCollectionUtils.findIndexOfItem(convertible_units,'label',units);
				if (i > -1) {
					result = convertible_units[i].func(value); // now we have value expressed as 'feet'.
					var max_factor:Number = MathUtils.determine_max_factor(source,result);
					if (max_factor == -1) {
						var key:String = min_delta_from(source).toString();
						result = result * Number(source[key]);
					} else {
						result = max_factor;
					}
				}
			} catch (err:Error) {}
			return result;
		}
		
		/**
		 * value is the value of the units such as 10 as in 10 miles or 3000 feet or the like.
		 * units must be one of UNITS. 
		 */
		public static function delta_from_units_lat(value:Number,units:String):Number {
			var is_neg:Boolean = value < 0;
			var result:Number = delta_from_units_lat_or_lng(Math.abs(value),units,LAT_DELTAS);
			return (is_neg) ? -result : result;
		}
		
		/**
		 * value is the value of the units such as 10 as in 10 miles or 3000 feet or the like.
		 * units must be one of UNITS. 
		 */
		public static function delta_from_units_lng(value:Number,units:String):Number {
			var is_neg:Boolean = value < 0;
			var result:Number = delta_from_units_lat_or_lng(Math.abs(value),units,LNG_DELTAS);
			return (is_neg) ? -result : result;
		}
		
		/**
		 * 
		 * @param pt1
		 * @param pt2
		 * @param units
		 * @return 
		 */
		public static function distance(pt1:LatLng, pt2:LatLng, units:String):Number {
			//  this formula works best for points close together or antipodal
			//  rounding error strikes when distance is one-quarter Earth's circumference
			//  (ref: wikipedia Great-circle distance)

			var sdlat:Number = Math.sin((pt1.latRadians() - pt2.latRadians()) / 2.0);
			var sdlon:Number = Math.sin((pt1.lngRadians() - pt2.lngRadians()) / 2.0);
			var result:Number = Math.sqrt(sdlat * sdlat + Math.cos(pt1.latRadians()) * Math.cos(pt2.latRadians()) * sdlon * sdlon);
			result = 2 * Math.asin(result);
			try {
				if (multipliers[units]) {
					result = result * multipliers[units];
				}
			} catch (err:Error) {}
			return result;
		}
		
		/**
		 * 
		 * @param value     ... value is latitude or longitude expressed as Number.
		 * @param units     ... number of units to add or subtract.
		 * @param direction ... true to add or false to subtract.
		 * @return  ... a number scaled for units with the proper sign (add this Lat or Lng to complete the operation). 
		 */
		public static function hemispherical_offset_for_lat_or_lng(value:Number,units:Number,direction:Boolean=false):Number {
			return (direction) ? ((value > 0) ? -units : units) : ((value > 0) ? units : -units);;
		}
		
		/**
		 * 
		 */
		public static function unit_test():void {
			var a:LatLng = new LatLng(37.4228327, -122.0850778);
			var delta:Point = new Point(0.00001,0.00001);
			var b:LatLng = new LatLng(a.lat()+delta.x, a.lng()+delta.y);
			var dst:Number = distance(a,b,UNITS.miles);
			trace(DebuggerUtils.getFunctionName(new Error())+'.1 --> a='+a.toString()+', b='+b.toString()+', dst='+dst.toString());
		}
	}
}