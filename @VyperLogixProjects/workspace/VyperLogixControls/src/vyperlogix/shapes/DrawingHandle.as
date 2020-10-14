package vyperlogix.shapes {
	import com.GUID;
	import com.VectorUtils;
	
	import flash.geom.Point;

	public class DrawingHandle extends Object {
		public var id:String;
		public var callback:Function;

		[Bindable]
		public var verticies:Array = [];

		[Bindable]
		public var lineSegments:Array = [];
		
		private var _segments_for_schema:Array = [];
		
		private var _vectors_for_schema:Array = [];
		
		[Bindable]
		public var points:int = -1;

		[Bindable]
		public var leastPt:Point;

		[Bindable]
		public var mostPt:Point;
		
		public static const PRECISION:int = 5;
		
		private static var _schema_:Array = [
			[1,2], // Between Segment 2 and 3 is the upper arm.
			[3,4], // Between Segment 4 and 5 is the left arm.
			[5,6], // Between Segment 6 and 7 is the lower left arm.
			[7,8], // Between Segment 8 and 9 is the lower right arm.
			[9,0] // Between Segment 10 and 1 is the right arm.
		];
		
		public function DrawingHandle() {
			super();
			this.id = GUID.create();
			this.leastPt = new Point(2^31,2^31);
			this.mostPt = new Point(-(2^31),-(2^31));
		}

		public function init_verticies(points:int):void {
			this.points = points;
			while (this.verticies.length > 0) {
				this.verticies.pop();
			}
			while (this.lineSegments.length > 0) {
				this.lineSegments.pop();
			}
			while (this._segments_for_schema.length > 0) {
				this._segments_for_schema.pop();
			}
			while (this._vectors_for_schema.length > 0) {
				this._vectors_for_schema.pop();
			}
		}
		
		public function get segment_schema():Array {
			return DrawingHandle._schema_;
		}
		
		public function get segments_for_schema():Array {
			// This is the crude form of the function that seeks to tie out-most vertex descriptions together...
			var aSeg:Array;
			var from:*;
			var to:*;
			if (this._segments_for_schema.length == 0) {
				for (var i:int = 0; i < this.segment_schema.length; i++) {
					aSeg = this.segment_schema[i];
					from = this.lineSegments[aSeg[0]];
					to = this.lineSegments[aSeg[aSeg.length-1]];
					this._segments_for_schema.push([from,to]);
				}
			}
			return this._segments_for_schema;
		}

		public function get vectors_for_schema():Array {
			// A vector is a pair of lines both of which have the same origin where the origin describes the outer-most vertex for any shape being drawn however this works best for stars.
			var aSeg:Array;
			var from:*;
			var to:*;
			var origin:Point;
			var to1:Point;
			var to2:Point;
			if (this._vectors_for_schema.length == 0) {
				for (var i:int = 0; i < this.segment_schema.length; i++) {
					aSeg = this.segment_schema[i];
					from = this.lineSegments[aSeg[0]];
					to = this.lineSegments[aSeg[aSeg.length-1]];
					var from_from_equals_to_from:Boolean = (from.points.from.equals(to.points.from));
					var from_from_equals_to_to:Boolean = (from.points.from.equals(to.points.to));
					if ( (from_from_equals_to_from) || (from_from_equals_to_to) ) {
						origin = from.points.from;
						to1 = from.points.to;
						if (from_from_equals_to_from) {
							to2 = to.points.to;
						} else if (from_from_equals_to_to) {
							to2 = to.points.from;
						}
					} else {
						var from_to_equals_to_from:Boolean = (from.points.to.equals(to.points.from));
						var from_to_equals_to_to:Boolean = (from.points.to.equals(to.points.to));
						if ( (from_to_equals_to_from) || (from_to_equals_to_to) ) {
							origin = from.points.to;
							to1 = from.points.from;
							if (from_to_equals_to_from) {
								to2 = to.points.to;
							} else if (from_to_equals_to_to) {
								to2 = to.points.from;
							}
						} else {
							var anError:Error = new Error('Cannot determine the vertex for Segment with labels of ('+from.label+' to '+to.label+').');
							throw anError;
						}
					}
					this._vectors_for_schema.push({'origin':origin,'to1':to1,'to2':to2});
				}
			}
			return this._vectors_for_schema;
		}
		
		private function gather_lineSegments():void {
			var i:String;
			var aPtFrom:Point;
			var aPtTo:Point;
			var iFrom:int;
			var iTo:int;
			var iMax:int = this.verticies.length - 1;
			for (i in this.verticies) {
				iFrom = int(i);
				iTo = (iFrom == iMax) ? 0 : iFrom + 1;
				aPtFrom = this.verticies[iFrom];
				aPtTo = this.verticies[iTo];
				if ( (aPtFrom.x != aPtTo.x) && (aPtFrom.y != aPtTo.y) ) {
					this.lineSegments.push({'label':'Segment '+(int(i)+1),'points':{'from':aPtFrom,'to':aPtTo}});
				}
			}
		}
		
		public function issue_callback(pt:*):void {
			var aPt:Point;
			if (this.callback is Function) {
				try {
					if (pt != null) {
						aPt = VectorUtils.precision_to(pt,DrawingHandle.PRECISION);
						this.verticies.push(aPt);
					} else {
						this.verticies = this.verticies;
						this.leastPt = new Point(2^31,2^31);
						this.mostPt = new Point(-(2^31),-(2^31));
						var i:String;
						for (i in this.verticies) {
							aPt = this.verticies[i];
							if (aPt.x < this.leastPt.x) {
								this.leastPt.x = aPt.x;
							}
							if (aPt.y < this.leastPt.y) {
								this.leastPt.y = aPt.y;
							}
							if (aPt.x > this.mostPt.x) {
								this.mostPt.x = aPt.x;
							}
							if (aPt.y > this.mostPt.y) {
								this.mostPt.y = aPt.y;
							}
						}
						this.gather_lineSegments();
					}
					this.callback(this,pt);
				} catch (err:Error) {
					trace('DrawingHandle.issue_callback().Error '+err.toString()+'\n'+err.getStackTrace());
				}
			}
		}
	}
}