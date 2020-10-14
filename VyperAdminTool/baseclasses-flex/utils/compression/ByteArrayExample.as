package utils.compression {
	
	
    import flash.display.Sprite;
    import flash.utils.ByteArray;
    import flash.errors.EOFError;

    public class ByteArrayExample extends Sprite {        
       
       
       
        public function ByteArrayExample() {
            var byteArr:ByteArray = new ByteArray();


            byteArr.writeBoolean(false);
            trace(byteArr.length);            // 1
            trace(byteArr[0]);            // 0

            byteArr.writeDouble(Math.PI);
            trace(byteArr.length);            // 9
            trace(byteArr[0]);            // 0
            trace(byteArr[1]);            // 64
            trace(byteArr[2]);            // 9
            trace(byteArr[3]);            // 33
            trace(byteArr[4]);            // 251
            trace(byteArr[5]);            // 84
            trace(byteArr[6]);            // 68
            trace(byteArr[7]);            // 45
            trace(byteArr[8]);            // 24
            
            byteArr.position = 0;

            try {
                trace(byteArr.readBoolean() == false); // true
            } 
            catch(e:EOFError) {
                trace(e);           // EOFError: Error #2030: End of file was encountered.
            }
            
            try {
                trace(byteArr.readDouble());        // 3.141592653589793
            }
            catch(e:EOFError) {
                trace(e);           // EOFError: Error #2030: End of file was encountered.
            }
            
            try {
                trace(byteArr.readDouble());
            } 
            catch(e:EOFError) {
                trace(e);            // EOFError: Error #2030: End of file was encountered.
            }
        }
    }
}