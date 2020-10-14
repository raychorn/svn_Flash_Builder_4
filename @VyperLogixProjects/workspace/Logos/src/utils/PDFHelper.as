package utils {
	import mx.collections.ArrayCollection;

	public class PDFHelper {
		public static var statements:Object = {};
		
		public static function asPagesArrayCollection(filename:String):ArrayCollection {
			var ar:Array = [];
			var data:Object = PDFHelper.statements[filename];
			for (var i:String in data.pages) {
				ar.push({'id':data.pages[i],'page_num':int(i)+1,'items_cnt':0,'scanned':true,'parsed':false,'processed':false});
			}
			return new ArrayCollection(ar);
		}
	}
}